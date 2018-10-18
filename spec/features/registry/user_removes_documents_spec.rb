require "rails_helper"

describe "User removes documents from a registered vessel", js: true do
  let(:vessel) { create(:registered_vessel) }
  let(:user) { create(:user) }

  before do
    login_to_part_3(user)
    visit vessel_path(vessel)
  end

  scenario "in general" do
    click_on("Documents")
    within("#documents") { page.accept_confirm { click_on("Remove") } }

    click_on("Documents")
    within("#documents") do
      expect(page)
        .to have_css(".red", text: "File removed")
    end
  end
end
