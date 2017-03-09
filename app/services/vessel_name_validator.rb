class VesselNameValidator
  class << self
    def valid?(part, name, port_code)
      @part = part
      @name = name
      @port_code = port_code

      return false if vessel_exists?
      return false if name_approval_exists?

      true
    end

    private

    def vessel_exists?
      Register::Vessel
        .in_part(@part)
        .where(name: @name)
        .where(port_code: @port_code)
        .exists?
    end

    def name_approval_exists?
      Submission::NameApproval
        .in_part(@part)
        .where(name: @name)
        .where(port_code: @port_code)
        .active
        .exists?
    end
  end
end
