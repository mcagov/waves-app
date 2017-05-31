class EcNo
  class << self
    def for_vessel(vessel)
      return unless Policies::Definitions.fishing_vessel?(vessel)

      vessel.ec_no.present? ? vessel.ec_no : "#{prefix}#{vessel.reg_no}"
    end

    private

    def prefix
      "GBR000"
    end
  end
end
