def expect_postcode_lookup
  # This doesn't test behaviour and I'm not sure how to do that.
  # Webmock reads the call to ideal postcodes as localhost.
  expect(page).to have_field("postcode_lookup_field")
  expect(page)
    .to have_css(".postcode-lookup-button", text: "Lookup address")
  expect(page).to have_css(".postcode-results-field")
end
