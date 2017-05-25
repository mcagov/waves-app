module ApplicationHelper
  def add_details_if_blank(str)
    str.blank? ? "Add details" : str
  end

  def formatted_amount(amount)
    amount = amount.is_a?(Integer) ? amount.to_f / 100 : amount.to_f
    "£#{number_with_precision(amount, precision: 2)}"
  end

  def y_n(val)
    val ? "Yes" : "No"
  end

  def rounded_int(value)
    value == value.to_i ? value.to_i : value.round(2)
  end
end
