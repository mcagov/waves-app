class Policies::Workflow
  class << self
    def approved_name_required?(submission)
      return false if submission.part.to_sym == :part_3
      return false if submission.registered_vessel
      return false if submission.name_approval
      true
    end

    def generate_official_no?(submission)
      submission.part.to_sym != :part_3
    end

    def uses_port_no?(obj)
      Policies::Definitions.fishing_vessel?(obj)
    end

    def uses_extended_engines?(obj)
      Policies::Definitions.fishing_vessel?(obj)
    end

    def uses_extended_owners?(obj)
      Policies::Definitions.fishing_vessel?(obj)
    end

    def uses_shareholding?(obj)
      obj.part.to_sym != :part_4
    end

    def uses_vessel_attribute?(attr, obj)
      @part = obj.part.to_sym

      WavesUtilities::Vessel.attributes_for(
        @part, Policies::Definitions.fishing_vessel?(obj)
      ).include?(attr.to_sym)
    end
  end
end
