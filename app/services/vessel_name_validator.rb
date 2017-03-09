class VesselNameValidator
  class << self
    def valid?(part, name, port_code, registration_type)
      @part = part.to_sym
      @name = name
      @port_code = port_code
      @registration_type = registration_type.to_s.to_sym

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
      if fishing_vessel?
        [
          "((part = 'part_2') or "\
          "(part = 'part_4' and registration_type = 'fishing')) "\
          "and port_code = ? and name = ?", @port_code, @name
        ]
      else
        ["part = ? and name = ?", @part, @name]
      end
    end

    def fishing_vessel?
      return true if @part == :part_2
      return true if @part == :part_4 && @registration_type == :fishing
      false
    end
  end
end
