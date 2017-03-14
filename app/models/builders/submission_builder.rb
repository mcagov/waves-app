class Builders::SubmissionBuilder # rubocop:disable Metrics/ClassLength
  class << self
    def build_defaults(submission)
      @submission = submission
      ensure_defaults
      perform

      @submission
    end

    private

    def ensure_defaults
      @submission.part ||= :part_3
      @submission.task ||= :new_registration
      @submission.source ||= :online
      @submission.ref_no ||= RefNo.generate_for(@submission)
    end

    def perform
      build_registry_info if @submission.registered_vessel
      build_changeset if @submission.registered_vessel

      perform_changeset_operations if @submission.changeset

      build_agent if @submission.applicant_is_agent
    end

    def perform_changeset_operations
      build_declarations
      build_managing_owner_and_correspondent
      build_engines
      build_mortgages
      build_beneficial_owners
      build_directed_bys
    end

    def build_registry_info
      return unless @submission.registry_info.blank?

      @submission.registry_info =
        @submission.registered_vessel.registry_info
    end

    def build_changeset
      return unless @submission.changeset.blank?

      @submission.changeset = @submission.registry_info
    end

    # Here we need to protect against re-building the owner declarations.
    # We can never be sure how many times a submission will pass through
    # this builder, so the rule is: if there are some declarations,
    # don't build anymore!
    def build_declarations # rubocop:disable Metrics/MethodLength
      if @submission.persisted?
        return unless Declaration.where(submission: @submission).empty?
      end

      submitted_owners = @submission.symbolized_changeset[:owners]
      completed_declarations = @submission.symbolized_changeset[:declarations]
      shareholder_groups = @submission.symbolized_changeset[:shareholder_groups]

      Builders::DeclarationBuilder.create(
        @submission,
        submitted_owners,
        completed_declarations,
        shareholder_groups)
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

    def build_managing_owner_and_correspondent
      Declaration.where(submission: @submission).each do |declaration|
        if declaration.owner.managing_owner
          @submission.managing_owner_id = declaration.id
        end

        if declaration.owner.correspondent
          @submission.correspondent_id = declaration.id
        end
      end
    end

    def build_engines
      if @submission.persisted?
        return unless Engine.where(parent: @submission).empty?
      end

      (@submission.symbolized_changeset[:engines] || []).each do |engine|
        submission_engine = Engine.new(engine.except(:id))
        submission_engine.parent = @submission
        submission_engine.save
      end
    end

    def build_mortgages
      if @submission.persisted?
        return unless Mortgage.where(parent: @submission).empty?
      end

      (@submission.symbolized_changeset[:mortgages] || []).each do |mortgage|
        except_keys = [:id, :mortgagees]
        submission_mortgage = Mortgage.new(mortgage.except(*except_keys))
        submission_mortgage.parent = @submission
        submission_mortgage.save

        build_mortgagees_for(submission_mortgage, mortgage)
      end
    end

    def build_mortgagees_for(submission_mortgage, mortgage)
      mortgage[:mortgagees].each do |mortgagee|
        submission_mortgagee = Mortgagee.new(mortgagee.except(:id))
        submission_mortgagee.mortgage = submission_mortgage
        submission_mortgagee.save
      end
    end

    def build_beneficial_owners
      if @submission.persisted?
        return unless BeneficialOwner.where(parent: @submission).empty?
      end
      submission_b_owners =
        @submission.symbolized_changeset[:beneficial_owners] || []

      submission_b_owners.each do |b_owner|
        submission_b_owner = BeneficialOwner.new(b_owner.except(:id))
        submission_b_owner.parent = @submission
        submission_b_owner.save
      end
    end

    def build_directed_bys
      if @submission.persisted?
        return unless DirectedBy.where(parent: @submission).empty?
      end
      submission_directed_bys =
        @submission.symbolized_changeset[:directed_bys] || []

      submission_directed_bys.each do |directed_by|
        submission_directed_by = DirectedBy.new(directed_by.except(:id))
        submission_directed_by.parent = @submission
        submission_directed_by.save
      end
    end
  end
end
