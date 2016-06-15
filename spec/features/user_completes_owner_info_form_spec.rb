require "rails_helper"

feature "User completes owner info form", type: :feature do
  before do
    create_list(:vessel_type, 5)
    visit page_path("start")
    click_on "Start now"

    complete_prerequisites_form
    complete_vessel_info_form
  end

  context "when the form is completed successfully" do
    describe "title" do
      describe "with suggested title" do
        scenario "owner's title is from the suggested titles list" do
          complete_owner_info_form

          owner = Owner.last
          from_suggested_title = Owner::SUGGESTED_TITLES.include?(owner.title)

          expect(from_suggested_title).to be_truthy
        end

        scenario "owner is successfully saved" do
          expect { complete_owner_info_form }.to change { Owner.count }.by(1)
        end

        scenario "user is taken to the next stage" do
          complete_owner_info_form
          expect(page).to have_current_path(path_for_step("declaration"))
        end
      end

      describe "with other title" do
        let!(:owner_info_fields) do
          default_owner_info_form_fields.merge(
            title: "Other (please specify)",
            title_other: "Cap'n"
          )
        end

        scenario "owner's title is not from the suggested titles list" do
          complete_owner_info_form(owner_info_fields)

          owner = Owner.last
          from_suggested_title = Owner::SUGGESTED_TITLES.include?(owner.title)

          expect(from_suggested_title).to be_falsey
        end

        scenario "owner is successfully saved" do
          expect do
            complete_owner_info_form(owner_info_fields)
          end.to change { Owner.count }.by(1)
        end

        scenario "user is taken to the next stage" do
          complete_owner_info_form(owner_info_fields)
          expect(page).to have_current_path(path_for_step("declaration"))
        end
      end
    end
  end

  context "when the form is not completed successfully" do
    before do
      invalid_fields = default_owner_info_form_fields.merge(
        first_name: "",
        last_name: "",
        mobile_number: ""
      )
      complete_owner_info_form(invalid_fields)
    end

    scenario "user is shown the form again" do
      expect(page).to have_text(t("registration.owner_info.title"))
    end

    scenario "user is shown error messages" do
      %w(first_name last_name mobile_number).each do |attribute|
        expect(page).to have_text(
          t("activerecord.errors.models.owner.attributes.#{attribute}.blank")
        )
      end
    end
  end
end
