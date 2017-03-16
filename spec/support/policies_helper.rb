def expect_field(bln, css)
  if bln
    expect(page).to have_css(css)
  else
    expect(page).not_to have_css(css)
  end
end

def expect_mortgages(bln)
  expect_field(bln, "#mortgages-tab")
end

def expect_port_no_fields(bln)
  expect_field(bln, ".port_no_fields")
end

def expect_service_description_fields(bln)
  expect_field(bln, ".service_description_fields")
end

def expect_last_registry_fields(bln)
  expect_field(bln, ".last_registry_fields")
end

def expect_underlying_registry_fields(bln)
  expect_field(bln, ".underlying_registry_fields")
end

def expect_referral_button(bln)
  expect_field(bln, ".btn-refer-submission")
end
