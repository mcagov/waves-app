require "rails_helper"

describe "User edits a submission" do
  before do
    visit_assigned_submission
    click_on "Edit Application"
  end

  xscenario "adding one declared owner and one undeclared owner" do
    click_on "Add Individual Owner"

    fill_in("Full Name", with: "Bob Jones")
    choose("SPAIN", from: "Nationality")
    fill_in("Email", with: "bob@example.com")
    fill_in("Phone NUmber", with: "123")

    fill_in(".address_1", with: "10 Downing St")
    fill_in(".address_2", with: "Westminster")
    fill_in(".address_3", with: "Something")
    fill_in("Town", with: "Penzance")

    check("Declaration signed")

    click_on "Add Individual Owner"

    fill_in("Full Name", with: "Alice Jones")

    click_on("Save Details")

    expect(Submission.last)

    click_on("Owners")
    expect(page).to have_css("#declaration_1 .declaration fa-check")
    expect(page).to have_css("#declaration_2 #declaration_completed_form")
  end
end
