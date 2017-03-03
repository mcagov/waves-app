class VesselPortNoValidator
  class << self
    def valid?(part, port_no, port_code)
      @part = part
      @port_no = port_no
      @port_code = port_code

      return false if vessel_exists?
      return false if name_approval_exists?

      true
    end

    private

    def vessel_exists?
      Register::Vessel
        .in_part(@part)
        .where(port_no: @port_no)
        .where(port_code: @port_code)
        .exists?
    end

    def name_approval_exists?
      Submission::NameApproval
        .in_part(@part)
        .where(port_no: @port_no)
        .where(port_code: @port_code)
        .where("approved_until is null or approved_until > now()")
        .exists?
    end
  end
end
