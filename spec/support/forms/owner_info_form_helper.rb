def country_name_from_code(country_code)
  ISO3166::Country[country_code].translations["en"]
end

def default_owner_info_form_fields
  form_fields = attributes_for(:owner)
  address_form_fields = attributes_for(:address)

  form_fields.merge!(address_form_fields)
  form_fields.delete(:address)

  form_fields
end

def complete_owner_info_form(fields = default_owner_info_form_fields)
  fill_form_and_submit(:owner_info, :update, fields)
end
