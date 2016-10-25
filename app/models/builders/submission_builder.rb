class Builders::SubmissionBuilder
  class << self
    def create(submission)
      @submission = submission

      ensure_defaults
      build_declarations

      @submission
    end

    private

    def ensure_defaults
      @submission.part ||= :part_3
      @submission.task ||= :new_registration
      @submission.source ||= :online
      @submission.ref_no = RefNo.generate
    end

    def build_declarations
      Builders::DeclarationBuilder.create(
        @submission,
        @submission.symbolized_changeset[:owners],
        @submission.symbolized_changeset[:declarations]
      )
    end
  end
end
