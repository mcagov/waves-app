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
      Register::Vessel.where(query_params).exists?
    end

    def name_approval_exists?
      Submission::NameApproval.where(query_params).active.exists?
    end

    def query_params
      {
        port_no: @port_no,
        port_code: @port_code,
      }
    end
  end
end
