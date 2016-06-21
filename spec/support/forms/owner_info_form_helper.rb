def assign_address_fields(address)
  fields = address.attributes.each_with_object({}) do |(key, value), object|
    object[key.to_sym] = value if value.present?
  end
  fields[:country] = country_name_from_code(fields[:country])

  fields
end

def default_owner_info_form_fields
  form_fields = attributes_for(:owner)

  form_fields[:nationality] = country_name_from_code(form_fields[:nationality])
  form_fields[:address] = assign_address_fields(form_fields[:address])

  form_fields
end

def complete_owner_info_form(fields = default_owner_info_form_fields)
  fill_form(:address, fields[:address])
  fill_form_and_submit(:owner, :update, fields.except(:address))
end
