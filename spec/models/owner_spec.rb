require "rails_helper"

describe Owner, type: :model do
  describe "validations" do
    context "when the owner is valid" do
      let!(:owner) { build(:owner) }

      before { owner.valid? }

      describe "first_name" do
        it "is present" do
          expect(owner.errors[:first_name]).to be_empty
        end
      end

      describe "last_name" do
        it "is present" do
          expect(owner.errors[:last_name]).to be_empty
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

      describe "mobile number" do
        it "is present" do
          expect(owner.errors[:mobile_number]).to be_empty
        end
      end
    end

    context "when the owner is invalid" do
      describe "first name" do
        it "is not present" do
          owner = build(:owner, first_name: " ")
          expect(owner).not_to be_valid
        end
      end

      describe "last name" do
        it "is not present" do
          owner = build(:owner, last_name: " ")
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
      end

      describe "mobile number" do
        it "is not present" do
          owner = build(:owner, mobile_number: " ")
          expect(owner).not_to be_valid
        end
      end
    end
  end
end
