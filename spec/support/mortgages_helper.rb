def expect_mortgages(bln)
  css = "#mortgages-tab"
  if bln
    expect(page).to have_css(css)
  else
    expect(page).not_to have_css(css)
  end
end
