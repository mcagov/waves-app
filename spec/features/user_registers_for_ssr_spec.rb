require "rails_helper"

feature "User registers for small ships register", type: :feature do
  before do
    visit root_path
    click_on "Start now"
  end

  context "prerequisites" do
    context "when registration is successful" do
      before do
        complete_prerequisites_form
      end

      scenario "user is taken to next stage" do
        expect(page).to have_current_path(path_for_next_step("vessel_info"))
      end
    end

    context "when registration is not successful" do
      before do
        complete_prerequisites_form(
          not_registered_before_on_ssr: true,
          owners_are_uk_residents: true
        )
      end

      scenario "user is shown registration form again" do
        expect(page).to have_text(t("registration.prerequisites.title"))
      end

      scenario "user is shown registration error messages" do
        expect(page).to have_text(error_message("not_registered_under_part_1"))
        expect(page).to have_text(error_message("user_eligible_to_register"))
      end
    end
  end

  context "vessel information" do
    before do
      complete_prerequisites_form
    end

    context "when registration is successful" do
      describe "hull ID" do
        describe "with valid ID" do
          scenario "user is taken to next stage" do
            expect { complete_vessel_info_form }.to change {
              Vessel.count
            }.by(1)

            expect(page).to have_current_path(
              path_for_next_step("owner_info")
            )
          end
        end

        describe "with non-applicable ID" do
          scenario "user is taken to next stage" do
            fields = default_vessel_info_form_fields
            fields.delete(:hin)

            expect do
              complete_vessel_info_form(fields)
            end.to change { Vessel.count }.by(1)

            expect(page).to have_current_path(
              path_for_next_step("owner_info")
            )
          end
        end
      end

      describe "vessel type" do
        describe "with listed vessel type" do
          scenario "user is taken to next stage" do
            expect { complete_vessel_info_form }.to change {
              Vessel.count
            }.by(1)

            expect(page).to have_current_path(
              path_for_next_step("owner_info")
            )
          end
        end

        describe "with other vessel type and text description" do
          scenario "user is taken to next stage" do
            fields = default_vessel_info_form_fields
            fields[:vessel_type_id] = "Other"
            fields[:vessel_type_other] = "Big Boat"

            expect do
              complete_vessel_info_form(fields)
            end.to change { Vessel.count }.by(1)

            expect(page).to have_current_path(
              path_for_next_step("owner_info")
            )
          end
        end
      end
    end

    xcontext "when registration is not successful" do
    end
  end
end
