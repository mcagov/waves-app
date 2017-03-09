class VesselPortNoValidator
  class << self
    def valid?(port_no, port_code)
      @port_no = port_no
      @port_code = port_code

      return false if vessel_exists?
      return false if name_approval_exists?

      true
    end

    private

    def vessel_exists?
      Register::Vessel
        .where(port_no: @port_no)
        .where(port_code: @port_code)
        .exists?
    end

    def name_approval_exists?
      Submission::NameApproval
        .where(port_no: @port_no)
        .where(port_code: @port_code)
        .active
        .exists?
    end
  end
end
