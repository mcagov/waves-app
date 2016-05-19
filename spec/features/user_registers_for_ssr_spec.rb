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
          {
            "not_registered_before_on_ssr" => true,
            "owners_are_uk_residents" => true
          }
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
            expect(page).to have_current_path(path_for_next_step("owner_info"))
          end
        end

        describe "with non-applicable ID" do
          scenario "user is taken to next stage" do
            expect(page).to have_current_path(path_for_next_step("owner_info"))
          end
        end
      end

      describe "vessel type" do
        describe "with listed vessel type" do
          scenario "user is taken to next stage" do
            expect(page).to have_current_path(path_for_next_step("owner_info"))
          end
        end

        describe "with other vessel type and text description" do
          scenario "user is taken to next stage" do
            expect(page).to have_current_path(path_for_next_step("owner_info"))
          end
        end
      end
    end

    xcontext "when registration is not successful" do
    end
  end

  def check_fields(fields)
    fields.each_with_object({}) do |(field, value), hash|
      field_key = t("simple_form.labels.registration.#{field}")
      hash[field_key] = value
    end
  end

  def error_message(field)
    t("activerecord.errors.models.registration.attributes.#{field}.accepted")
  end

  def path_for_next_step(step)
    registration_id = Registration.last.id
    step_string = I18n.t("wicked.#{step}")

    "/registration_wizard/#{step_string}?registration_id=#{registration_id}"
  end

  def complete_prerequisites_form(fields = default_prerequisites_form_fields)
    fill_form_and_submit(
      :registration,
      :update,
      check_fields(fields)
    )
  end

  def default_prerequisites_form_fields
    {
      "not_registered_before_on_ssr" => true,
      "not_registered_under_part_1" => true,
      "owners_are_uk_residents" => true,
      "user_eligible_to_register" => true
    }.freeze
  end

  def default_vessel_info_form_fields
    {
      "name" => "Boaty McBoatface",
      "hin" => random_hin,
      "make_and_model" => "",
      "length_in_centimeters" => "666",
      "number_of_hulls" => "1",
      "vessel_type_id" => random_vessel_type.id,
      "mmsi_number" => "",
      "radio_call_sign" => ""
    }
  end

  def random_hin
    twelve_digits = rand(999999999999).to_s.rjust(12, "0")
    "UK-#{twelve_digits}"
  end

  def random_vessel_type
    VesselType.offset(rand(VesselType.count)).first
  end
end
