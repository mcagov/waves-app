require "rails_helper"

describe Owner, type: :model do
  describe "validations" do
    context "when the owner is valid" do
      let!(:owner) { build(:owner) }

      before { owner.valid? }

      describe "name" do
        it "is present" do
          expect(owner.errors[:name]).to be_empty
        end
      end

      describe "nationality" do
        it "is present" do
          expect(owner.errors[:nationality]).to be_empty
        end

        it "is valid" do
          expect(owner.errors[:nationality]).to be_empty
        end

        it "is an eligible nationality" do
          expect(owner.errors[:nationality]).to be_empty
        end
      end

      describe "email" do
        it "is present" do
          expect(owner.errors[:email]).to be_empty
        end
      end

      describe "phone number" do
        it "is present" do
          expect(owner.errors[:phone_number]).to be_empty
        end
      end
    end

    context "when the owner is invalid" do
      describe "name" do
        it "is not present" do
          owner = build(:owner, name: " ")
          expect(owner).not_to be_valid
        end
      end

      describe "nationality" do
        it "is not present" do
          owner = build(:owner, nationality: " ")
          expect(owner).not_to be_valid
        end

        it "is invalid" do
          owner = build(:owner, nationality: "GBR")
          expect(owner).not_to be_valid
        end

        it "is an ineligible nationality" do
          owner = build(:owner, nationality: "XX")
          expect(owner).not_to be_valid
        end
      end

      describe "email" do
        it "is not present" do
          owner = build(:owner, email: " ")
          expect(owner).not_to be_valid
        end

        it "is invalid" do
          owner = build(:owner, email: "owner[at]example.com")
          expect(owner).not_to be_valid
        end
      end

      describe "phone number" do
        it "is not present" do
          owner = build(:owner, phone_number: " ")
          expect(owner).not_to be_valid
        end
      end
    end
  end
end
