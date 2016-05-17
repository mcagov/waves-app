require "rails_helper"

describe Registration, type: :model do
  include RegistrationsMixin

  subject(:registration) { described_class.new(parameters) }

  before do
    registration.valid?
  end

  describe "prerequisites" do
    context "when the registration is valid" do
      let!(:parameters) { valid_parameters }

      it { expect(registration).to be_valid }

      it "expects that the ship is not registered before on the SSR" do
        expect(registration.errors[:not_registered_before_on_ssr]).to be_empty
      end

      it "expects that the ship is not registered under Part 1" do
        expect(registration.errors[:not_registered_under_part_1]).to be_empty
      end

      it "expects that the ship owners are UK residents" do
        expect(registration.errors[:owners_are_uk_residents]).to be_empty
      end

      it "expects that the user is eligible to register the ship" do
        expect(registration.errors[:user_eligible_to_register]).to be_empty
      end
    end

    context "when the registration is invalid" do
      let!(:parameters) { invalid_parameters }

      it { expect(registration).not_to be_valid }

      it "returns the appropriate errors" do
        locale_prefix = "activerecord.errors.models.registration.attributes"
        registration_parameters_hash.keys.each do |param|
          message = I18n.t("#{locale_prefix}.#{param}.accepted")
          expect(registration.errors[param]).to eq([message])
        end
      end
    end
  end
end
