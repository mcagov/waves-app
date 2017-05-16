class Tonnage
  include ActionView::Helpers::NumberHelper
  def initialize(mode, value)
    @mode = mode
    @value = value
  end

  def to_s
    return "" unless @value
    case @mode
    when :register
      @value.round.to_s
    else
      number_with_precision(@value, precision: 2)
    end
  end
end
