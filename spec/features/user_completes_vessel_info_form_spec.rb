require "rails_helper"

feature "User completes vessel info form", type: :feature do
  before do
    create_list(:vessel_type, 5)

    session_set_prerequisites
    visit vessel_info_path
  end

  context "when the form is completed successfully" do
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

  xcontext "when the form is not completed successfully" do
  end
end
