require "rails_helper"

describe Preregistration, type: :model do
  subject(:preregistration) { described_class.new(parameters) }

  before do
    preregistration.valid?
  end

  context "when the preregistration is valid" do
    let!(:parameters) { valid_parameters }

    it { expect(preregistration).to be_valid }

    it "expects that the ship is not registered before on the SSR" do
      expect(preregistration.errors[:not_registered_before_on_ssr]).to be_empty
    end

    it "expects that the ship is not registered under Part 1" do
      expect(preregistration.errors[:not_registered_under_part_1]).to be_empty
    end

    it "expects that the ship owners are UK residents" do
      expect(preregistration.errors[:owners_are_uk_residents]).to be_empty
    end

    it "expects that the user is eligible to register the ship" do
      expect(preregistration.errors[:user_eligible_to_register]).to be_empty
    end
  end

  context "when the preregistration is invalid" do
    let!(:parameters) { invalid_parameters }

    it { expect(preregistration).not_to be_valid }

    it "shows the appropriate errors" do
      parameters_hash.keys.each do |param|
        message = I18n.t("activemodel.errors.models.preregistration.attributes.#{param}.accepted")
        expect(preregistration.errors[param]).to eq([message])
      end
    end
  end

  def parameters_hash(value = nil)
    {
      not_registered_before_on_ssr: value,
      not_registered_under_part_1: value,
      owners_are_uk_residents: value,
      user_eligible_to_register: value
    }
  end

  def valid_parameters
    parameters_hash("1")
  end

  def invalid_parameters
    parameters_hash("0")
  end
end
