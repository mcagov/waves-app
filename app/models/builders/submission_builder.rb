class Builders::SubmissionBuilder
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

      if @submission.changeset
        build_declarations
        build_managing_owner_and_correspondent
        build_engines
      end

      build_agent if @submission.applicant_is_agent
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
  end
end
