require "rails_helper"

describe "User searches" do
  before { login_to_part_3 }

  scenario "for a registered vessel" do
    vessel = create(:register_vessel)
    reg_no = vessel.reg_no

    find("input#search").set(reg_no)
    click_on("Go!")

    expect(page).to have_css("h1", vessel.name)
  end

  scenario "for a submission" do
    submission = create(:new_registration)

    find("input#search").set(submission.ref_no)
    click_on("Go!")

    expect(page).to have_css("h1", "New Registration")
  end

  scenario "nothing found" do
    find("input#search").set("foo")
    click_on("Go!")

    expect(page).to have_text("Nothing found")
  end

  scenario "no search criteria" do
    click_on("Go!")

    expect(page).to have_text("Nothing found")
  end
end
