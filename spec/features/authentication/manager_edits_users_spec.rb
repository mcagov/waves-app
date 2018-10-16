require "rails_helper"

describe "Manager edits users" do
  before do
    reset_mailer
    create(:user, name: "Alice")
    login_as_system_manager
    visit admin_users_path
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

    click_on("Log Out")
    expect(unread_emails_for("bob@example.com").count).to eq(1)
    open_email("bob@example.com")

    click_first_link_in_email
    expect(page).to have_css("h1", text: "Waves Account Activation")
  end

  scenario "disabling a user" do
    within("#users") { click_on("Alice") }
    find("#user_disabled").set(true)
    click_on("Save")

    within("#users") do
      expect(page).to have_css("td.status", text: "Disabled")
    end

    expect(User.find_by(name: "Alice")).to be_disabled
  end
end
