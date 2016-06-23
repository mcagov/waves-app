def set_prerequisites_cookie(fields = default_prerequisites_form_fields)
  create_cookie(step.to_s, fields.to_json)
end

def set_vessel_info_cookie(fields = default_vessel_info_form_fields)
  create_cookie(step.to_s, fields.to_json)
end

def set_owner_info_cookie(fields = default_owner_info_form_fields)
  create_cookie(step.to_s, fields.to_json)
end

def set_delivery_address_cookie(fields = default_delivery_address_form_fields)
  create_cookie(step.to_s, fields.to_json)
end

def set_declaration_cookie(fields = default_declaration_form_fields)
  create_cookie(step.to_s, fields.to_json)
end

def expect_cookie_to_be_unset
  expect(get_me_the_cookie(step.to_s)).to be_nil
end

def expect_cookie_to_be_set
  expect(get_me_the_cookie(step.to_s)).not_to be_nil
end

def clear_cookie_for_step
  delete_cookie(step.to_s)
end
