require "rails_helper"

describe "User adds a new manual entry", type: :feature do
  before do
    login_to_part_3
    visit new_manual_entry_path
  end

  scenario "for a new registration" do
    select("New Registration", from: "Task Type")
    click_on("Save Application")

    expect(page).to have_css(".breadcrumb", text: "My Tasks")
    expect(page).to have_css("h1", text: "New Registration")

    fill_in("Vessel Name", with: "BOB'S BOAT")
    fill_in("HIN", with: "MY_HIN")
    fill_in("Make and Model", with: "MARK 2")
    fill_in("Length", with: "12")
    fill_in("Vessel Type (other)", with: "TEACUP")
    fill_in("MMSI Number", with: "MMSI-123")
    fill_in("Radio Call Sign", with: "RADIO-CALL")
    select("3", from: "Number of Hulls")

    click_on("Save Application")

    expect(page).to have_css("h5", text: "Manual Entry")
    expect(page).to have_css("#vessel-name", text: "BOB'S BOAT")
    expect(page).to have_css("#vessel-hin", text: "MY_HIN")
    expect(page).to have_css("#vessel-make_and_model", text: "MARK 2")
    expect(page).to have_css("#vessel-length_in_meters", text: "12")
    expect(page).to have_css("#vessel-number_of_hulls", text: "3")
    expect(page).to have_css("#vessel-vessel_type", text: "OTHER")
    expect(page).to have_css("#vessel-vessel_type_other", text: "TEACUP")
    expect(page).to have_css("#vessel-mmsi_number", text: "MMSI-123")
    expect(page).to have_css("#vessel-radio_call_sign", text: "RADIO-CALL")

    # regression test, ensure that tasks list doesn't break
    # when the manual entry has no payment
    visit tasks_my_tasks_path
    expect(page).to have_css("h1", text: "My Tasks")
  end

  scenario "for a change of vessel details with an invalid official number" do
    select("Change of Registry Details", from: "Task Type")
    fill_in("Official Number", with: "Bob")
    click_on("Save Application")

    expect(page).to have_css(".submission_vessel_reg_no", text: "not found")
  end

  scenario "for a change of vessel details with a valid official number" do
    select("Change of Registry Details", from: "Task Type")
    fill_in("Official Number", with: create(:registered_vessel).reg_no)
    click_on("Save Application")

    expect(page).to have_css("h1", text: "Change of Registry Details")
  end
end
