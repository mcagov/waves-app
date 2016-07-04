def default_delivery_address_form_fields
  attributes_for(:address)
end

def complete_delivery_address_form(fields = default_delivery_address_form_fields)
  if fields
    fields[:country] = country_name_from_code(fields[:country])

    choose("Yes")
    fill_form(:delivery_address, fields)
  else
    choose("No")
  end

  click_on submit(:delivery_address, :update)
end
