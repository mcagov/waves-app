class Policies::Advisories
  class << self
    def for_submission(submission)
      @submission = submission
      @advisories = []

      perform

      @advisories
    end

    private

    def perform
      check_safety_certificate
    end

    def check_safety_certificate
      return unless Policies::Definitions.fishing_vessel?(@submission)

      if @submission.documents.safety_certificates.not_expired.empty?
        @advisories << :safety_certificate
      end
    end
  end
end
