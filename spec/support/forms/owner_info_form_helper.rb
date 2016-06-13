def default_owner_info_form_fields
  form_fields = attributes_for(:owner)

  country_code = form_fields[:nationality]
  country_name = ISO3166::Country[country_code].name
  form_fields[:nationality] = country_name

  form_fields
end

def complete_owner_info_form(fields = default_owner_info_form_fields)
  fill_form_and_submit(
    :owner,
    :update,
    fields
  )
end
