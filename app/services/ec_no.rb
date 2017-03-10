class EcNo
  class << self
    def for_submission(submission)
      return unless submission.registered_vessel
      return unless Policies::Definitions.fishing_vessel?(submission)

      "#{prefix}#{submission.vessel_reg_no}"
    end

    def for_vessel(vessel)
      return unless Policies::Definitions.fishing_vessel?(vessel)

      "#{prefix}#{vessel.reg_no}"
    end

    private

    def prefix
      "GBR000"
    end
  end
end
