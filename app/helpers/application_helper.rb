module ApplicationHelper
  def country_name_from_code(country_code)
    ISO3166::Country[country_code].translations["en"]
  end
end
