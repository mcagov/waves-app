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
      check_fishing_vessel_safety_certificate
    end

    def check_fishing_vessel_safety_certificate
      return unless Policies::Definitions.fishing_vessel?(@submission)

      @advisories << :fishing_vessel_safety_certificate
    end
  end
end
