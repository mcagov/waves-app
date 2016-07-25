require "rails_helper"

feature "User completes owner info form", type: :feature do
  before do
    clear_cookies!
    visit additional_owner_info_path
  end

  scenario "user adds a single additional owner" do
    complete_additional_owner_info_form
    expect(page).to have_current_path(path_for_step("delivery_address"))
  end

  scenario "user adds two additional owners" do
    within(".form-group", text: "Are there any more owners?") do
      choose("Yes")
    end
    complete_additional_owner_info_form
    expect(page).to have_current_path(path_for_step("additional_owner_info"))

    complete_additional_owner_info_form
    expect(page).to have_current_path(path_for_step("delivery_address"))

    expect(get_me_the_cookie("additional_owner_info_count")[:value].to_i).to eq(2)
  end
end
