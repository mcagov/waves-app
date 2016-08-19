require "rails_helper"

feature "User logs in", type: :feature, js: true do
  before do
    visit root_path
  end

  context "using email/password" do
    let!(:password) { "meh" }
    let!(:user) { create(:user, password: password, name: 'Bob') }

    scenario "user is taken to the dashboard with correct info" do
      perform_sign_in user.email, password

      expect(page).to_not have_content("Login")
      expect(page).to have_content(unclaimed_tasks_text)

      # logging out
      find("#logout").click
      expect(page).to have_content("Login")
      expect(page).to_not have_content(unclaimed_tasks_text)
    end

    scenario "user is not taken to the dashboard with incorrect info" do
      perform_sign_in user.email, "wrong_password"

      expect(page).to have_content("Login")
      expect(page).to_not have_content(unclaimed_tasks_text)
    end
  end

  scenario "visiting when not logged in" do
    visit tasks_unclaimed_path

    expect(page).to have_content("Login")
    expect(page).to_not have_content(unclaimed_tasks_text)
  end

  def perform_sign_in(email, password)
    fill_in "Email address", with: email
    fill_in "Password", with: password

    click_on "Login"
  end

  def unclaimed_tasks_text
    "Unclaimed Tasks"
  end
end
