class VesselNameValidator
  class << self
    def valid?(part, name, port_code, registration_type)
      @part = part
      @name = name
      @port_code = port_code
      @registration_type = registration_type

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
        part: @part,
        name: @name,
        port_code: @port_code,
      }
    end
  end
end
