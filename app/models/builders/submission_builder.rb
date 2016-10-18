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
      @submission.ref_no = RefNo.generate("3N")
    end

    def build_declarations
      Builders::DeclarationBuilder.create(
        @submission,
        @submission.user_input[:owners],
        @submission.user_input[:declarations]
      )
    end
  end
end
