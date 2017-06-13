def expect_link_to_export_or_print(bln)
  if bln
    expect(page).to have_link("Export to Excel")
    expect(page).to have_link("Print")
  else
    expect(page).not_to have_link("Export to Excel")
    expect(page).not_to have_link("Print")
  end
end

def expect_filter_fields(bln)
  if bln
    expect(page).to have_button("Apply Filter")
  else
    expect(page).not_to have_button("Apply Filter")
  end
end
