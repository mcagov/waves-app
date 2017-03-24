class RegNoValidator
  class << self
    def valid?(reg_no)
      @reg_no = reg_no

      return false if reg_no_exists?
      return false if reg_no_pattern_invalid?

      true
    end

    private

    def reg_no_exists?
      Register::Vessel.where(reg_no: @reg_no).exists?
    end

    def reg_no_pattern_invalid?
      false
    end
  end
end
