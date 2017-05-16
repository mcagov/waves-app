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
      number_with_precision(@value.round, precision: 0, delimiter: ",")
    else
      number_with_precision(@value, precision: 2, delimiter: ",")
    end
  end
end
