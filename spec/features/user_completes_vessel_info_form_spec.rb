require "rails_helper"

feature "User completes vessel info form", type: :feature do
  before do
    create_list(:vessel_type, 5)

    set_prerequisites_cookie

    visit vessel_info_path
    clear_cookie_for_step
  end

  let!(:step) { :vessel_info }

  context "when the form is completed successfully" do
    scenario "vessel info is successfully saved in session" do
      expect_cookie_to_be_unset

      complete_vessel_info_form

      expect_cookie_to_be_set
    end

    describe "hull ID" do
      describe "with valid ID" do
        scenario "user is taken to next stage" do
          complete_vessel_info_form

          expect(page).to have_current_path(path_for_step("owner_info"))
        end
      end

      describe "with non-applicable ID" do
        scenario "user is taken to next stage" do
          fields = default_vessel_info_form_fields
          fields.delete(:hin)

          complete_vessel_info_form(fields)

          expect(page).to have_current_path(path_for_step("owner_info"))
        end
      end
    end

    describe "vessel type" do
      describe "with listed vessel type" do
        scenario "user is taken to next stage" do
          complete_vessel_info_form

          expect(page).to have_current_path(path_for_step("owner_info"))
        end
      end

      describe "with other vessel type and text description" do
        scenario "user is taken to next stage" do
          fields = default_vessel_info_form_fields
          fields[:vessel_type_id] = "Other (please specify)"
          fields[:vessel_type_other] = "Big Boat"

          complete_vessel_info_form(fields)

          expect(page).to have_current_path(path_for_step("owner_info"))
        end
      end
    end
  end

  context "when the form is not completed successfully" do
    scenario "vessel info is not successfully saved in session" do
      fields = default_vessel_info_form_fields
      fields.delete(:name)

      complete_vessel_info_form(fields)

      expect_cookie_to_be_unset
    end
  end
end
