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
        expect(page).to have_current_path(path_for_step("vessel_info"))
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
        expect(page).to have_text(error_message("not_owned_by_company"))
        expect(page).to have_text(error_message("not_commercial_fishing_or_submersible"))
        expect(page).to have_text(error_message("owners_are_eligible_to_register"))
        expect(page).to have_text(error_message("not_registered_on_foreign_registry"))
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
              path_for_step("owner_info")
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
              path_for_step("owner_info")
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
              path_for_step("owner_info")
            )
          end
        end

        describe "with other vessel type and text description" do
          scenario "user is taken to next stage" do
            fields = default_vessel_info_form_fields
            fields[:vessel_type_id] = "Other (please specify)"
            fields[:vessel_type_other] = "Big Boat"

            expect do
              complete_vessel_info_form(fields)
            end.to change { Vessel.count }.by(1)

            expect(page).to have_current_path(
              path_for_step("owner_info")
            )
          end
        end
      end
    end

    xcontext "when registration is not successful" do
    end
  end

  xcontext "owner information" do
  end

  context "declaration step" do
    context "when registration is successful" do
      before do
        complete_prerequisites_form
        complete_vessel_info_form
        complete_owner_info_form

        complete_declaration_form
      end

      scenario "user is taken to next stage" do
        expect(page).to have_current_path(path_for_step("payment"))
      end
    end

    context "when registration is not successful" do
      before do
        complete_prerequisites_form
        complete_vessel_info_form
        complete_owner_info_form

        complete_declaration_form(
          eligible_under_regulation_89: true,
          eligible_under_regulation_90: true
        )
      end

      scenario "user is shown declaration form again" do
        expect(page).to have_text(t("registration.declaration.title"))
      end

      scenario "user is shown declaration error messages" do
        expect(page).to have_text(
          error_message("understands_false_statement_is_offence")
        )
      end
    end
  end
end
