require "rails_helper"

describe "Manager edits users" do
  before do
    reset_mailer
    login_as_system_manager
    click_on("User Management")
  end

  scenario "adding an operational user" do
    click_on("Add New User")
    fill_in("Name", with: "")
    fill_in("Email", with: "foo")
    click_on("Save")

    expect(page).to have_css(".user_name", text: "can't be blank")
    expect(page).to have_css(".user_email", text: "is invalid")

    fill_in("Name", with: "Bob")
    fill_in("Email", with: "bob@example.com")
    select("Operational User", from: "Role")
    click_on("Save")

    within("#users") do
      expect(page).to have_css(".name", text: "Bob")
      expect(page).to have_css(".email", text: "bob@example.com")
      expect(page).to have_css(".access_level", text: "Operational User")
      expect(page).to have_css(".status", text: "Active")
    end

    expect(unread_emails_for("bob@example.com").count).to eq(1)
    open_email("bob@example.com")

    click_first_link_in_email
    expect(page).to have_css("h1", "Change your password")
  end
end
