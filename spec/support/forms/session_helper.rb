def session_set_prerequisites(fields = default_prerequisites_form_fields)
  page.set_rack_session(prerequisites: fields)
end

def session_set_vessel_info(fields = default_vessel_info_form_fields)
  page.set_rack_session(vessel_info: fields)
end

def session_set_owner_info(fields = default_owner_info_form_fields)
  page.set_rack_session(owner_info: fields)
end

def session_set_delivery_address(fields = default_delivery_address_form_fields)
  page.set_rack_session(delivery_address: fields)
end

def session_set_declaration(fields = default_declaration_form_fields)
  page.set_rack_session(declaration: fields)
end

