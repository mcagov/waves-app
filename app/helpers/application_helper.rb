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
    "£#{number_with_precision(amount.to_f / 100, precision: 2)}"
  end
end
