def set_cookie_for_step(step, fields)
  create_cookie(step, fields.to_json)
end

def set_prerequisites_cookie(fields = default_prerequisites_form_fields)
  set_cookie_for_step("prerequisites", fields)
end

def set_vessel_info_cookie(fields = default_vessel_info_form_fields)
  if fields[:vessel_type_id]
    fields[:vessel_type_id] = VesselType.find_by(
      designation: fields[:vessel_type_id]
    ).id
  end

  set_cookie_for_step("vessel_info", fields)
end

def set_owner_info_cookie(fields = default_owner_info_form_fields)
  fields[:country] = country_code_from_name(fields[:country])
  fields[:nationality] = country_code_from_name(fields[:nationality])

  create_cookie(:owner_info_1, fields.to_json)
  create_cookie(:owner_info_count, 1)
end

def set_delivery_address_cookie(fields = default_delivery_address_form_fields)
  set_cookie_for_step("delivery_address", fields)
end

def set_declaration_cookie(fields = default_declaration_form_fields)
  set_cookie_for_step("declaration", fields)
end

def expect_cookie_to_be_unset
  expect(get_me_the_cookie(step.to_s)).to be_nil
end

def expect_cookie_to_be_set
  expect(get_me_the_cookie(step.to_s)).not_to be_nil
end

def expect_cookie_for(key)
  expect(get_me_the_cookie(key.to_s)).not_to be_nil
end

def clear_cookies!
  Capybara.current_session.driver.browser.clear_cookies
end

def get_cookie_for_step
  JSON.parse(get_me_the_cookie(step.to_s)[:value])
end

def get_cookie_for(key)
  JSON.parse(get_me_the_cookie(key.to_s)[:value])
end
