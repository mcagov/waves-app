require "rails_helper"

describe Registration, type: :model do
  subject(:registration) { described_class.new(parameters) }

  before do
    registration.valid?
  end

  describe "prerequisites" do
    context "when the registration is valid" do
      let!(:parameters) { valid_prerequisites_parameters }

      it { expect(registration).to be_valid }

      it "is not registered before on the SSR" do
        expect(registration.errors[:not_registered_before_on_ssr]).to be_empty
      end

      it "is not registered under Part 1" do
        expect(registration.errors[:not_registered_under_part_1]).to be_empty
      end

      it "is not owned by a company" do
        expect(registration.errors[:not_owned_by_company]).to be_empty
      end

      it "is not a commercial fishing vessel of submersible" do
        expect(registration.errors[:not_commercial_fishing_or_submersible]).to be_empty
      end

      it "the owners are UK residents" do
        expect(registration.errors[:owners_are_uk_residents]).to be_empty
      end

      it "the owners are eligible to register the ship" do
        expect(registration.errors[:owners_are_eligible_to_register]).to be_empty
      end

      it "is not registered on a foreign registry" do
        expect(registration.errors[:not_registered_on_foreign_registry]).to be_empty
      end
    end

    context "when the registration is invalid" do
      let!(:parameters) { invalid_prerequisites_parameters }

      it { expect(registration).not_to be_valid }

      it "returns the appropriate errors" do
        locale_prefix = "activerecord.errors.models.registration.attributes"
        prerequisites_parameters_hash.keys.each do |param|
          message = I18n.t("#{locale_prefix}.#{param}.accepted")
          expect(registration.errors[param]).to eq([message])
        end
      end
    end
  end

  def prerequisites_parameters_hash(value = "0")
    {
      not_registered_before_on_ssr: value,
      not_registered_under_part_1: value,
      not_owned_by_company: value,
      not_commercial_fishing_or_submersible: value,
      owners_are_uk_residents: value,
      owners_are_eligible_to_register: value,
      not_registered_on_foreign_registry: value
    }
  end

  def valid_prerequisites_parameters
    prerequisites_parameters_hash("1")
  end

  def invalid_prerequisites_parameters
    prerequisites_parameters_hash
  end
end
