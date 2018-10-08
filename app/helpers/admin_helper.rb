module AdminHelper
  def y_n(bln)
    bln ? "Yes" : "No"
  end

  def service_price(service, part)
    standard = service.price_for(part, :standard)
    premium = service.price_for(part, :premium)

    "Standard: #{standard ? formatted_amount(standard) : 'n/a'}<br/>"\
    "Premium: #{premium ? formatted_amount(premium) :  'n/a'}".html_safe
  end
end
