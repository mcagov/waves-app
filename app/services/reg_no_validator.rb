class RegNoValidator
  class << self
    def valid?(reg_no, part)
      @reg_no = reg_no.upcase
      @part = part.to_sym

      return true if @part == :part_4
      return false if reg_no_exists?
      return false if reg_no_pattern_invalid?

      true
    end

    private

    def reg_no_exists?
      Register::Vessel.in_part(@part).where(reg_no: @reg_no).exists?
    end

    def reg_no_pattern_invalid?
      pattern = SequenceNumber::Generator::REG_NO_PATTERNS[@part]
      length_match = pattern.length == @reg_no.length
      prefix_match = @reg_no.match(/\A#{pattern.delete("#")}.*/)

      if length_match && prefix_match
        @reg_no >=
          (pattern.delete("#") + SequenceNumber::Generator::REG_NO_START[@part])
      else
        false
      end
    end
  end
end
