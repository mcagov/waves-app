require "rails_helper"

describe "User converts finance payment", type: :feature, js: true do
  before do
    create(
      :locked_finance_payment,
      part: :part_3,
      task: :new_registration,
      vessel_name: "MY BOAT", applicant_name: "BOB")

    login_to_part_3
    click_on("Fees Received")
  end

  scenario "when they have claimed it they can 'convert' it" do
    click_on("Claim")
    click_on("My Tasks")
    click_on("MY BOAT")

    expect(page).to have_css("h1", text: "New Registration")

    within(actions_css) do
      click_on("Convert to Application")
    end

    expect(page).to have_css(".alert", text: "successfully converted")
    expect(page).to have_current_path(tasks_my_tasks_path)
    expect(Submission.last.vessel.name).to eq("MY BOAT")
  end

  scenario "when they have claimed it they can edit the documents received" do
    click_on("Claim")
    click_on("My Tasks")
    click_on("MY BOAT")

    click_on(edit_finance_payment_link)
    fill_in("Documents Received", with: "Excel file, C&M")
    click_button("Save")

    expect(page).to have_css("#documents-received", text: "Excel file, C&M")
  end

  scenario "when they have not claimed it they can't 'convert' or edit it" do
    click_on("MY BOAT")

    expect(page).to have_css("h1", text: "New Registration")
    expect(page).not_to have_css(actions_css)
    expect(page).not_to have_link(edit_finance_payment_link)
  end
end

def actions_css
  "#actions"
end

def edit_finance_payment_link
  "Edit Finance Payment"
end
