require "rails_helper"

describe Address, type: :model do
  describe "validations" do
    context "when the address is valid" do
      let!(:address) { build(:address) }

      before { address.valid? }

      describe "address_1" do
        it "is present" do
          expect(address.errors[:address_1]).to be_empty
        end
      end

      describe "town" do
        it "is present" do
          expect(address.errors[:town]).to be_empty
        end
      end

      describe "postcode" do
        it "is present" do
          expect(address.errors[:postcode]).to be_empty
        end
      end

      describe "country" do
        it "is present" do
          expect(address.errors[:country]).to be_empty
        end

        it "is valid" do
          expect(address.errors[:country]).to be_empty
        end

        it "is from the ISO3166 list of countries" do
          expect(address.errors[:country]).to be_empty
        end
      end
    end

    context "when the address is invalid" do
      describe "address_1" do
        it "is not present" do
          address = build(:address, address_1: " ")
          expect(address).not_to be_valid
        end
      end

      describe "town" do
        it "is not present" do
          address = build(:address, town: " ")
          expect(address).not_to be_valid
        end
      end

      describe "postcode" do
        it "is not present" do
          address = build(:address, postcode: " ")
          expect(address).not_to be_valid
        end
      end

      describe "country" do
        it "is not present" do
          address = build(:address, country: " ")
          expect(address).not_to be_valid
        end

        it "is invalid" do
          address = build(:address, country: "GBR")
          expect(address).not_to be_valid
        end

        it "is not from the ISO3166 list of countries" do
          address = build(:address, country: "XX")
          expect(address).not_to be_valid
        end
      end
    end
  end
end
