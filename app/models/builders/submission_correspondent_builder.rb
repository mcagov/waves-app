class Builders::SubmissionCorrespondentBuilder
  class << self
    def create(submission, correspondent)
      @submission = submission
      @submission.update_attributes(
        correspondent_id: correspondent.id,
        applicant_name: correspondent.name,
        applicant_email: correspondent.email
      )
    end
  end
end
