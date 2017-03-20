require "rails_helper"

describe "User views issues CSR", type: :feature do
  scenario "in general" do
    visit_assigned_csr_submission

    expect(page).to have_css("#csr_form")
  end
end
