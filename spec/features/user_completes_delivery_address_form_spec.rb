require "rails_helper"

feature "User completes delivery address form", type: :feature do
  before do
    create_list(:vessel_type, 5)
    visit page_path("start")
    click_on "Start now"

    complete_prerequisites_form
    complete_vessel_info_form
    complete_owner_info_form
  end

  context "when the user chooses an alternative delivery address" do
    let!(:address) { build(:address) }

    context "when the form is successfully completed" do
      scenario "delivery address is saved" do
        expect do
          complete_delivery_address_form(address)
        end.to change { Address.count }.by(1)
      end

      scenario "registration is associated with a delivery address" do
        registration = Registration.last
        expect(registration.delivery_address).to be_nil

        complete_delivery_address_form(address)

        registration.reload
        expect(registration.delivery_address).not_to be_nil
      end

      scenario "user is taken to the next stage" do
        complete_delivery_address_form(address)
        expect(page).to have_current_path(path_for_step("declaration"))
      end
    end

    context "when the form is not successfully completed" do
      let!(:invalid_address) { build(:address, address_1: "", postcode: " ") }

      scenario "delivery address is not saved" do
        expect do
          complete_delivery_address_form(invalid_address)
        end.to change { Address.count }.by(0)
      end

      scenario "user is shown the form again" do
        complete_delivery_address_form(invalid_address)
        expect(page).to have_text(t("registration.delivery_address.title"))
      end

      scenario "user is shown error messages" do
        complete_delivery_address_form(invalid_address)

        %w(address_1 postcode).each do |attribute|
          expect(page).to have_text(
            t("activerecord.errors.models.address.attributes.#{attribute}.blank")
          )
        end
      end
    end
  end

  context "when the user doesn't choose an alternative delivery address" do
    scenario "user is taken to the next stage" do
      complete_delivery_address_form
      expect(page).to have_current_path(path_for_step("declaration"))
    end
  end
end
