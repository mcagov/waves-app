require "rails_helper"

describe "User forgets password" do
  before do
    reset_mailer
    create(:user, name: "Bob", email: "bob@example.com")
    visit root_path
  end

  scenario "requesting a new password" do
    click_on("Request a new password")

    fill_in("Email", with: "bob@example.com")
    click_on("Send me reset password instructions")

    open_email("bob@example.com")
    click_first_link_in_email

    fill_in("New password", with: "")
    click_on("Save my password")

    expect(page).to have_css(".user_password",
                             text: "can't be blank")

    fill_in("New password", with: "abc123456")
    fill_in("Confirm your new password", with: "abc123456")
    click_on("Save my password")

    expect(page).to have_css("h1", text: "Select Register")
  end
end
