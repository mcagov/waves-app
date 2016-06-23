require "rails_helper"

feature "User completes delivery address form", type: :feature do
  before do
    clear_cookies!
    create_list(:vessel_type, 5)

    set_prerequisites_cookie
    set_vessel_info_cookie
    set_owner_info_cookie

    visit delivery_address_path
  end

  let!(:step) { :delivery_address }

  context "when the user chooses an alternative delivery address" do
    context "when the form is successfully completed" do
      before { complete_delivery_address_form }

      scenario "delivery address is successfully saved in session" do
        expect_cookie_to_be_set
      end

      scenario "user is taken to the next stage" do
        expect(page).to have_current_path(path_for_step("declaration"))
      end
    end

    context "when the form is not successfully completed" do
      before do
        invalid_address = build(:address, address_1: "", postcode: " ")
        invalid_fields = invalid_address.attributes.symbolize_keys
        invalid_fields.reject! { |_, v| v.nil? }

        complete_delivery_address_form(invalid_fields)
      end

      scenario "delivery address is not successfully saved in session" do
        expect_cookie_to_be_unset
      end

      scenario "user is shown the form again" do
        expect(page).to have_text(t("delivery_address.form.title"))
      end

      scenario "user is shown error messages" do
        %w(address_1 postcode).each do |attribute|
          expect(page).to have_text(
            t("activemodel.errors.models.delivery_address.attributes.#{attribute}.blank")
          )
        end
      end
    end
  end

  context "when the user doesn't choose an alternative delivery address" do
    scenario "user is taken to the next stage" do
      set_delivery_address_cookie

      complete_delivery_address_form(nil)
      expect(page).to have_current_path(path_for_step("declaration"))

      expect_cookie_to_be_unset
    end
  end
end
