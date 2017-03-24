class RegNoValidator
  class << self
    def valid?(reg_no)
      @reg_no = reg_no.upcase

      return false if reg_no_exists?
      return false if reg_no_pattern_invalid?

      true
    end

    private

    def reg_no_exists?
      Register::Vessel.where(reg_no: @reg_no).exists?
    end

    def reg_no_pattern_invalid?
      SequenceNumber::Generator::REG_NO_PATTERNS.each_value do |pattern|
        length_match = pattern.length == @reg_no.length
        prefix_match = @reg_no.match(/\A#{pattern.delete("#")}.*/)

        return true if length_match && prefix_match
      end
      false
    end
  end
end
