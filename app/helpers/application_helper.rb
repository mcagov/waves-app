module ApplicationHelper
  def country_name_from_code(country_code)
    ISO3166::Country[country_code].translations["en"]
  end

  def css_tick(bln)
    if bln
      content_tag(:div, ' ', class: 'i fa fa-check green')
    else
      content_tag(:div, ' ', class: 'i fa fa-times red')
    end
  end
end
