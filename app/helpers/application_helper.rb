module ApplicationHelper
  def owner_country_list
    ["UNITED KINGDOM"]
  end

  def all_country_list
    WavesUtilities::Country.all
  end

  def vessel_type_list
    ["OTHER"] + WavesUtilities::VesselType.all
  end

  def nationality_list
    WavesUtilities::Nationality.all
  end

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

  def letter_sequence(n)
    n.to_s(26).each_char.map { |i| ("A".."Z").to_a[i.to_i(26)] }.join
  end
end
