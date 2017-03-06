require "rails_helper"

feature "User adds documents to part_2 submission", type: :feature, js: true do
  scenario "in general" do
    visit_name_approved_part_2_submission
    click_on("Certificates & Documents")
    click_on("Add Certificate/Document")

    page.attach_file("document_assets_attributes_0_file", mca_file)

    select("Carving & Marking Note", from: "Type")
    select("Recognised Organisation", from: "Issuing Authority")
    fill_in("Date of Expiry", with: "01/02/2016")
    fill_in("Notes", with: "Some text")
    fill_in("Date Received", with: "02/02/2016")

    click_on("Save Certificate/Document")

    click_on("Certificates & Documents")
    expect(page)
      .to have_css(".entity_type", text: "Carving & Marking Note")
    expect(page)
      .to have_css(".issuing_authority", text: "Recognised Organisation")
    expect(page).to have_css(".noted_at", "01/02/2016")
    expect(page).to have_css(".expires_at", "02/02/2016")
    expect(page).to have_link("mca_test.pdf", href: /mca_test.pdf/)

    within(".remove-document") { click_on("Remove") }
    expect(page).not_to have_css(".entity_type")

    expect(Document.count).to eq(0)
  end
end
