class Builders::SubmissionBuilder
  class << self
    def build_defaults(submission)
      @submission = submission
      ensure_defaults

      build_registry_info if @submission.registered_vessel
      build_changeset if @submission.registered_vessel
      build_declarations if @submission.changeset

      @submission
    end

    private

    def ensure_defaults
      @submission.part ||= :part_3
      @submission.task ||= :new_registration
      @submission.source ||= :online
      @submission.ref_no ||= RefNo.generate
    end

    def build_registry_info
      return unless @submission.registry_info.blank?

      @submission.registry_info = {
        vessel_info: @submission.registered_vessel.attributes,
        owners: @submission.registered_vessel.owners.map(&:attributes),
      }
    end

    def build_changeset
      return unless @submission.changeset.blank?
      @submission.changeset = @submission.registry_info
    end

    def build_declarations
      return unless Declaration.where(submission: @submission).empty?

      submitted_owners = @submission.symbolized_changeset[:owners]
      completed_declarations = @submission.symbolized_changeset[:declarations]

      Builders::DeclarationBuilder.create(
        @submission, submitted_owners, completed_declarations)
    end
  end
end
