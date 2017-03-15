class Department
  attr_reader :part

  def initialize(part, registration_type = "")
    @part = part.to_sym
    @registration_type = (registration_type || "").to_sym
  end

  def code
    case @part
    when :part_1
      @registration_type == :pleasure ? :pleasure : :commercial
    when :part_2
      :fishing
    when :part_3
      :ssr
    when :part_4
      :bareboat
    end
  end
end
