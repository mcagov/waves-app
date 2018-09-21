class Builders::SubmissionBuilder
  class << self
    def build_defaults(submission)
      @submission = submission
      perform

      @submission.save
    end

    private

    def perform
      build_changeset if @submission.registered_vessel
      perform_changeset_operations if @submission.changeset
      build_agent if @submission.applicant_is_agent
    end

    def perform_changeset_operations
      build_declarations
      build_engines
      build_managers
      build_mortgages
      build_charterers
      build_beneficial_owners
      build_directed_bys
      build_managed_bys
    end

    def build_changeset
      return unless @submission.changeset.blank?

      @submission.changeset = @submission.registered_vessel.try(:registry_info)
    end

    def build_declarations # rubocop:disable Metrics/MethodLength
      return unless Declaration.where(submission: @submission).empty?

      submitted_owners = @submission.symbolized_changeset[:owners]
      completed_declarations = @submission.symbolized_changeset[:declarations]
      shareholder_groups = @submission.symbolized_changeset[:shareholder_groups]

      Builders::DeclarationBuilder.create(
        @submission,
        submitted_owners,
        completed_declarations,
        shareholder_groups)

      Declaration.where(submission: @submission).each do |declaration|
        owner = declaration.owner
        next unless owner
        @submission.managing_owner_id = owner.id if owner.managing_owner
        @submission.correspondent_id = owner.id if owner.correspondent
      end
    end

    def build_agent
      agent_attrs = @submission.agent.attributes

      if @submission.applicant_name
        agent_attrs[:name] = @submission.applicant_name
      end
      if @submission.applicant_email
        agent_attrs[:email] = @submission.applicant_email
      end

      @submission.agent = agent_attrs
    end

    def build_engines
      return unless Engine.where(parent: @submission).empty?

      (@submission.symbolized_changeset[:engines] || []).each do |engine|
        submission_engine = Engine.new(engine.except(:id))
        submission_engine.parent = @submission
        submission_engine.save
      end
    end

    def build_managers
      return unless Manager.where(parent: @submission).empty?

      (@submission.symbolized_changeset[:managers] || []).each do |manager|
        except_keys = [:id, :safety_management]
        submission_manager = Manager.new(manager.except(*except_keys))
        submission_manager.parent = @submission
        submission_manager.save

        build_safety_management_for(submission_manager, manager)
      end
    end

    def build_safety_management_for(submission_manager, manager)
      return unless manager[:safety_management]

      safety_management = SafetyManagement.new(manager[:safety_management])
      safety_management.id = nil
      safety_management.parent = submission_manager
      safety_management.save
    end

    def build_mortgages
      return unless Mortgage.where(parent: @submission).empty?

      (@submission.symbolized_changeset[:mortgages] || []).each do |mortgage|
        except_keys = [:id, :mortgagors, :mortgagees]
        submission_mortgage = Mortgage.new(mortgage.except(*except_keys))
        submission_mortgage.parent = @submission
        submission_mortgage.save

        build_mortgagors_for(submission_mortgage, mortgage)
        build_mortgagees_for(submission_mortgage, mortgage)
      end
    end

    def build_mortgagors_for(submission_mortgage, mortgage)
      mortgage[:mortgagors].each do |mortgagor|
        submission_mortgagor = Mortgagor.new(mortgagor.except(:id))
        submission_mortgagor.parent = submission_mortgage
        submission_mortgagor.save
      end
    end

    def build_mortgagees_for(submission_mortgage, mortgage)
      mortgage[:mortgagees].each do |mortgagee|
        submission_mortgagee = Mortgagee.new(mortgagee.except(:id))
        submission_mortgagee.parent = submission_mortgage
        submission_mortgagee.save
      end
    end

    def build_charterers
      return unless Charterer.where(parent: @submission).empty?

      (@submission.symbolized_changeset[:charterers] || []).each do |charterer|
        except_keys = [:id, :charter_parties]
        submission_charterer = Charterer.new(charterer.except(*except_keys))
        submission_charterer.parent = @submission
        submission_charterer.save

        build_charter_parties_for(submission_charterer, charterer)
      end
    end

    def build_charter_parties_for(submission_charterer, charterer)
      charterer[:charter_parties].each do |charter_party|
        submission_charter_party = CharterParty.new(charter_party.except(:id))
        submission_charter_party.parent = submission_charterer
        submission_charter_party.save

        if submission_charter_party.correspondent
          @submission.correspondent_id = submission_charter_party.id
        end
      end
    end

    def build_beneficial_owners
      return unless BeneficialOwner.where(parent: @submission).empty?

      submission_b_owners =
        @submission.symbolized_changeset[:beneficial_owners] || []

      submission_b_owners.each do |b_owner|
        submission_b_owner = BeneficialOwner.new(b_owner.except(:id))
        submission_b_owner.parent = @submission
        submission_b_owner.save
      end
    end

    def build_directed_bys
      return unless DirectedBy.where(parent: @submission).empty?

      submission_directed_bys =
        @submission.symbolized_changeset[:directed_bys] || []

      submission_directed_bys.each do |directed_by|
        submission_directed_by = DirectedBy.new(directed_by.except(:id))
        submission_directed_by.parent = @submission
        submission_directed_by.save
      end
    end

    def build_managed_bys
      return unless ManagedBy.where(parent: @submission).empty?

      submission_managed_bys =
        @submission.symbolized_changeset[:managed_bys] || []

      submission_managed_bys.each do |managed_by|
        submission_managed_by = ManagedBy.new(managed_by.except(:id))
        submission_managed_by.parent = @submission
        submission_managed_by.save
      end
    end
  end
end
