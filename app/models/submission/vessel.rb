class Submission::Vessel < WavesUtilities::Vessel
  def port_name
    WavesUtilities::Port.new(port_code).name if port_code
  end

  def pln
    "#{port_code}#{port_no}"
  end

  # After implementation, this should be moved to WavesUtilities
  class << self
    # rubocop:disable Metrics/MethodLength
    def attributes_for(part, fishing_vessel = false)
      @attributes = WavesUtilities::Vessel::ATTRIBUTES
      @part = part.to_sym

      case part
      when :part_1
        @attributes - port_no_fields - service_description_fields - underlying_registry_fields

      when :part_2
        @attributes - underlying_registry_fields - smc_fields

      when :part_4
        if fishing_vessel
          @attributes - last_registry_fields
        else
          @attributes - port_no_fields - last_registry_fields - service_description_fields
        end
      end
    end

    def port_no_fields
      [
        :port_no,
        :ec_number,
      ]
    end

    def last_registry_fields
      [
        :last_registry_country,
        :last_registry_no,
        :last_registry_port,
      ]
    end

    def underlying_registry_fields
      [
        :underlying_registry,
        :underlying_registry_identity_no,
        :underlying_registry_port,
      ]
    end

    def smc_fields
      [
        :smc_issuing_authority,
        :smc_auditor ,
        :abs_ississuing_authority,
        :issc_auditor,
      ]
    end

    def service_description_fields
      [
        :entry_into_service_at,
        :area_of_operation,
        :alternative_activity,
      ]
    end
  end
end
