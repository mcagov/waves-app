def country_name_from_code(country_code)
  ISO3166::Country[country_code].translations["en"]
end

def country_code_from_name(country_name)
  country = ISO3166::Country.find_country_by_name(country_name.downcase)
  country.alpha2
end

def default_owner_info_form_fields
  form_fields = attributes_for(:owner)
  address_form_fields = attributes_for(:address)

  form_fields.merge!(address_form_fields)
  form_fields.delete(:address)

  %i(nationality country).each do |country_field|
    form_fields[country_field] = country_name_from_code(
      form_fields[country_field]
    )
  end

  form_fields
end

def complete_owner_info_form(fields = default_owner_info_form_fields)
  fill_form_and_submit(:owner_info, :update, fields)
end

def complete_additional_owner_info_form(fields = default_owner_info_form_fields)
  fill_form_and_submit(:additional_owner_info, :update, fields)
end
