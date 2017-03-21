class Builders::CsrFormBuilder
  class << self
    def build(submission)
      @submission = submission

      @csr_form = submission.csr_form

      @csr_form
    end

    private
  end
end
