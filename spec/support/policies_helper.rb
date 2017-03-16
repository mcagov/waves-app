def expect_mortgages(bln)
  css = "#mortgages-tab"
  if bln
    expect(page).to have_css(css)
  else
    expect(page).not_to have_css(css)
  end
end

def expect_port_no(bln)
  css = "#port-no"
  if bln
    expect(page).to have_css(css)
  else
    expect(page).not_to have_css(css)
  end
end

def expect_referral_button(bln)
  css = ".btn-refer-submission"
  if bln
    expect(page).to have_css(css)
  else
    expect(page).not_to have_css(css)
  end
end
