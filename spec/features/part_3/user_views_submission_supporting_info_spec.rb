require "rails_helper"

feature "User views submission supporting info", type: :feature, js: true do
  before do
    visit_claimed_task(
      submission: submission,
      service: create(:service, :registry_not_editable))

    click_on("Supporting Info")
  end

  context "closure / destroyed" do
    let(:submission) do
      create(:submission,
             changeset: { closure: build(:closure_other) })
    end

    scenario do
      expect(page).to have_css(".closure-reason", text: "Other")
      expect(page).to have_css(".closure-actioned_at", text: "23/06/2016")
      expect(page).to have_css(".closure-other_reason", text: "DONT WANT")
    end
  end

  context "closure / sold" do
    let(:submission) do
      create(:submission,
             changeset: { closure: build(:closure_sold) })
    end

    scenario do
      expect(page).to have_css(".closure-reason", text: "Sold")
      expect(page).to have_css(".closure-new_owner_name", text: "BOB")
      expect(page).to have_css(".closure-new_owner_email", text: "bob@example")
      expect(page).to have_css(".closure-new_owner_phone", text: "12345")
    end
  end

  context "closure / registered_elsewhere" do
    let(:submission) do
      create(:submission,
             changeset: { closure: build(:closure_registered_elsewhere) })
    end

    scenario do
      expect(page).to have_css(".closure-reason", text: "Registered elsewhere")
      expect(page).to have_css(".closure-new_flag", text: "FRANCE")
      expect(page).to have_css(".closure-new_flag_reason", text: "MOVED HOUSE")
    end
  end
end
