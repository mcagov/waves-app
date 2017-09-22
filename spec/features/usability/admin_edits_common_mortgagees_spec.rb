require "rails_helper"

describe "Admin edits common mortgagees" do
  scenario "in general" do
    login_as_system_manager

    visit admin_common_mortgagees_path

    click_on("Add Commonly-used Mortgagee")
    fill_in("Name", with: "Corp Mortgages")
    fill_in("Address 1", with: "10 Downing St")
    click_on("Save")

    click_on("Corp Mortgages")
    fill_in("Address 1", with: "20 Cheap St")
    click_on("Save")

    within("tr.mortgagee") do
      expect(page).to have_css(".address", text: "20 Cheap St")
      click_on("Remove")
    end

    expect(page).not_to have_css("tr.mortgagee")
  end
end
