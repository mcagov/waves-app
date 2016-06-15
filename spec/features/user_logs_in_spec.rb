require "rails_helper"

feature "User logs in", type: :feature, js: true do
  before do
    visit root_path
  end

  xcontext "using ActiveDirectory"

  context "using email/password" do
    let!(:password) { "meh" }
    let!(:user) { create(:user, password: password) }

    scenario "user is taken to the dashboard with correct info" do
      perform_sign_in user.email, password

      expect(page).to_not have_content("Login")
      expect(page).to have_content("Part III")
    end

    scenario "user is not taken to the dashboard with incorrect info" do
      perform_sign_in user.email, "wrong_password"

      expect(page).to have_content("Bad email or password.")
      expect(page).to_not have_content("Part III")
    end
  end

  def perform_sign_in(email, password)
    click_on "Login"

    fill_in "Email address", with: email
    fill_in "Password", with: password

    click_on "Sign in"
  end
end
