def complete_delivery_address_form(address = nil)
  if address
    choose("Yes")
    fill_form(:delivery_address, assign_address_fields(address))
  else
    choose("No")
  end

  click_on submit(:registration, :update)
end

