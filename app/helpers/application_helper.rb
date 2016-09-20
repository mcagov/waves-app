module ApplicationHelper
  def eligible_country_list
    WavesUtilities::Country.all.map { |c| c[0] }
  end
end
