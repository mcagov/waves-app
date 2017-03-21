require "rails_helper"

describe "User views issues CSR", type: :feature do
  scenario "in general" do
    visit_assigned_csr_submission

    expect(find("#csr_vessel_name").value).to eq("Registered Boat 1")
  end
end
