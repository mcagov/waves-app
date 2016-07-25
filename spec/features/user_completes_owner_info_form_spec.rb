require "rails_helper"

feature "User completes owner info form", type: :feature do
  before do
    clear_cookies!
    create_list(:vessel_type, 5)

    set_prerequisites_cookie
    set_vessel_info_cookie

    visit owner_info_path
  end

  let!(:step) { :owner_info }

  context "when the form is completed successfully" do
    describe "title" do
      describe "with suggested title" do
        before { complete_owner_info_form }

        scenario "owner's title is from the suggested titles list" do
          owner_title = get_cookie_for_step["title"]
          from_suggested_title = Owner::SUGGESTED_TITLES.include?(owner_title)

          expect(from_suggested_title).to be_truthy
        end

        scenario "owner is successfully saved in session" do
          expect_cookie_to_be_set
        end

        scenario "user is taken to the next stage" do
          expect(page).to have_current_path(path_for_step("delivery_address"))
        end
      end

      describe "with other title" do
        before do
          owner_info_fields = default_owner_info_form_fields.merge(
            title: "Other (please specify)",
            title_other: "Cap'n"
          )

          complete_owner_info_form(owner_info_fields)
        end

        scenario "owner's title is not from the suggested titles list" do
          owner_title = get_cookie_for_step["title"]
          from_suggested_title = Owner::SUGGESTED_TITLES.include?(owner_title)

          expect(from_suggested_title).to be_falsey
        end

        scenario "owner is successfully saved in session" do
          expect_cookie_to_be_set
        end

        scenario "user is taken to the next stage" do
          expect(page).to have_current_path(path_for_step("delivery_address"))
        end
      end
    end
  end

  context "when the form is not completed successfully" do
    before do
      invalid_fields = default_owner_info_form_fields.merge(
        first_name: "",
        last_name: "",
        phone_number: ""
      )

      complete_owner_info_form(invalid_fields)
    end

    scenario "owner info is not successfully saved in session" do
      expect_cookie_to_be_unset
    end

    scenario "user is shown the form again" do
      expect(page).to have_text(t("owner_info.form.title"))
    end

    scenario "user is shown error messages" do
      %w(first_name last_name phone_number).each do |attribute|
        expect(page).to have_text(
          t("activemodel.errors.models.owner_info.attributes.#{attribute}.blank")
        )
      end
    end
  end

  context "when there are multiple owners" do
    before do
      within(".form-group", text: "Are there any more owners?") do
        choose("Yes")
      end
      complete_owner_info_form
    end

    scenario "user is redirected to the additional_owner_info form" do
      expect(page).to have_current_path(path_for_step("additional_owner_info"))
    end
  end
end
