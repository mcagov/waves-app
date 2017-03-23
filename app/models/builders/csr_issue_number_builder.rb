class Builders::CsrIssueNumberBuilder
  class << self
    def build(submission)
      @registered_vessel = submission.registered_vessel

      submission.csr_form.update_attributes(issue_number: max_issue_number + 1)

      submission
    end

    private

    def max_issue_number
      @registered_vessel.csr_forms.maximum(:issue_number).to_i
    end
  end
end
