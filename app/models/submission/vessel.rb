class Submission::Vessel < WavesUtilities::Vessel
  def port_name
    WavesUtilities::Port.new(port_code).name if port_code
  end

  def pln
    "#{port_code}#{port_no}"
  end

  # After implementation, this should be moved to WavesUtilities
  class << self # rubocop:disable Metrics/MethodLength
    def attributes_for(part, fishing_vessel = false)
      @attributes = WavesUtilities::Vessel::ATTRIBUTES
      @part = part.to_sym

      case part
      when :part_1
        @attributes - [:port_no]
      when :part_2
        @attributes - []
      when :part_4
        if fishing_vessel
          @attributes - []
        else
          @attributes - [:port_no]
        end
      end
    end
  end
end
