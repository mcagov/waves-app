require "rails_helper"

feature "User logs in", type: :feature, js: true do
  before do
    visit root_path
  end

  xcontext "using ActiveDirectory" do
  end

  context "using email/password" do
    let!(:user) { create(:user, password: "meh") }

    scenario "user is taken to the dashboard with correct info" do
      click_on "Login"

      fill_in "Email address", with: user.email
      fill_in "Password", with: "meh"

      click_on "Sign in"

      expect(page.path).to equal("lol")
    end
  end
end
