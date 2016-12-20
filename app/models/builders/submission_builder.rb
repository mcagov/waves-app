class Builders::SubmissionBuilder
  class << self
    def build_defaults(submission)
      @submission = submission
      ensure_defaults

      build_registry_info if @submission.registered_vessel
      build_changeset if @submission.registered_vessel
      build_declarations if @submission.changeset
      build_agent if @submission.applicant_is_agent

      @submission
    end

    private

    def ensure_defaults
      @submission.part ||= :part_3
      @submission.task ||= :new_registration
      @submission.source ||= :online
      @submission.ref_no ||= RefNo.generate_for(@submission)
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

    def build_declarations
      # Here we need to protect against re-building the owner declaraions
      # We can never be sure how many times a submission will pass through
      # this builder, so the rule is: if there are some declarations,
      # don't build anymore!
      if @submission.persisted?
        return unless Declaration.where(submission: @submission).empty?
      end

      submitted_owners = @submission.symbolized_changeset[:owners]
      completed_declarations = @submission.symbolized_changeset[:declarations]

      Builders::DeclarationBuilder.create(
        @submission, submitted_owners, completed_declarations)
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
  end
end
