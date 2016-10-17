class Builders::SubmissionBuilder
  class << self
    def create(submission)
      @submission = submission
      @submission.ref_no = RefNo.generate("3N")

      Builders::DeclarationBuilder.create(
        @submission,
        @submission.user_input[:owners],
        @submission.user_input[:declarations]
      )
      @submission
    end
  end
end
