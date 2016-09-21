module ApplicationHelper
  def eligible_country_list
    WavesUtilities::Country.all.map { |c| c[0] }
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
end
