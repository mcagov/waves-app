require "rails_helper"

describe Vessel, type: :model do
  describe "validations" do
    context "when the vessel is valid" do
      describe "vessel name" do
        it "is present" do
          vessel = build(:vessel)
          vessel.valid?

          expect(vessel.errors[:name]).to be_empty
        end
      end

      describe "hull ID number" do
        it "is blank" do
          vessel = build(:vessel, hin: "")
          vessel.valid?

          expect(vessel.errors[:hin]).to be_empty
        end

        it "is valid" do
          vessel = build(:vessel)
          vessel.valid?

          expect(vessel.errors[:hin]).to be_empty
        end
      end

      describe "length" do
        it "is present" do
          vessel = build(:vessel)
          vessel.valid?

          expect(vessel.errors[:length_in_centimeters]).to be_empty
        end

        it "is greater than 0 centimetres" do
          vessel = build(:vessel, length_in_centimeters: 1)
          vessel.valid?

          expect(vessel.errors[:length_in_centimeters]).to be_empty
        end

        it "is less than 23.99 metres" do
          vessel = build(:vessel, length_in_centimeters: 2398)
          vessel.valid?

          expect(vessel.errors[:length_in_centimeters]).to be_empty
        end

        it "is exactly 23.99 metres" do
          vessel = build(:vessel, length_in_centimeters: 2399)
          vessel.valid?

          expect(vessel.errors[:length_in_centimeters]).to be_empty
        end
      end

      describe "number of hulls" do
        it "is present" do
          vessel = build(:vessel)
          vessel.valid?

          expect(vessel.errors[:number_of_hulls]).to be_empty
        end

        it "is greater than 0" do
          vessel = build(:vessel, number_of_hulls: 1)
          vessel.valid?

          expect(vessel.errors[:number_of_hulls]).to be_empty
        end

        it "is less than 6" do
          vessel = build(:vessel, number_of_hulls: 5)
          vessel.valid?

          expect(vessel.errors[:number_of_hulls]).to be_empty
        end

        it "is exactly 6" do
          vessel = build(:vessel, number_of_hulls: 6)
          vessel.valid?

          expect(vessel.errors[:number_of_hulls]).to be_empty
        end
      end

      describe "MMSI number" do
        let!(:vessel) { build(:vessel) }

        before { vessel.valid? }

        it "is present" do
          expect(vessel.errors[:mmsi_number]).to be_empty
        end

        it "is unique" do
          expect(vessel.errors[:mmsi_number]).to be_empty
        end

        it "is the correct length" do
          expect(vessel.errors[:mmsi_number]).to be_empty
        end

        it "contains an valid MID" do
          expect(vessel.errors[:mmsi_number]).to be_empty
        end
      end

      describe "radio call sign" do
        it "is present and valid format" do
          vessel = build(:vessel)
          vessel.valid?

          expect(vessel.errors[:radio_call_sign]).to be_empty
        end

        it "is 6 characters long" do
          radio_call_sign = random_radio_call_sign(6)
          vessel = build(:vessel, radio_call_sign: radio_call_sign)
          vessel.valid?

          expect(vessel.errors[:radio_call_sign]).to be_empty
        end

        it "is 7 characters long" do
          radio_call_sign = random_radio_call_sign(7)
          vessel = build(:vessel, radio_call_sign: radio_call_sign)
          vessel.valid?

          expect(vessel.errors[:radio_call_sign]).to be_empty
        end
      end
    end

    context "when the vessel is invalid" do
      describe "vessel name" do
        it "is not present" do
          vessel = build(:vessel, name: " ")
          expect(vessel).not_to be_valid
        end
      end

      describe "hull ID number" do
        it "is not valid" do
          invalid_hin = random_hin[0..-2]
          vessel = build(:vessel, hin: invalid_hin)

          expect(vessel).not_to be_valid
        end

        it "does not contain a valid country code" do
          invalid_hin = "XX-#{random_hin[3..-1]}"
          vessel = build(:vessel, hin: invalid_hin)

          expect(vessel).not_to be_valid
        end
      end

      describe "length" do
        it "is not present" do
          vessel = build(:vessel, length_in_centimeters: nil)
          expect(vessel).not_to be_valid
        end

        it "is less than 1 centimetre" do
          vessel = build(:vessel, length_in_centimeters: 0)
          expect(vessel).not_to be_valid
        end

        it "is greater than 23.99 metres" do
          vessel = build(:vessel, length_in_centimeters: 2400)
          expect(vessel).not_to be_valid
        end
      end

      describe "number of hulls" do
        it "is not present" do
          vessel = build(:vessel, number_of_hulls: nil)
          expect(vessel).not_to be_valid
        end

        it "is less than 1" do
          vessel = build(:vessel, number_of_hulls: 0)
          expect(vessel).not_to be_valid
        end

        it "is greater than 6" do
          vessel = build(:vessel, number_of_hulls: 7)
          expect(vessel).not_to be_valid
        end
      end

      describe "MMSI number" do
        it "is not present" do
          vessel = build(:vessel, mmsi_number: nil)
          expect(vessel).not_to be_valid
        end

        it "is not unique" do
          invalid_mmsi_number = create(:vessel).mmsi_number
          vessel = build(:vessel, mmsi_number: invalid_mmsi_number)

          expect(vessel).not_to be_valid
        end

        it "is not the correct length" do
          invalid_mmsi_number = random_mmsi_number[0..-2]
          vessel = build(:vessel, mmsi_number: invalid_mmsi_number)

          expect(vessel).not_to be_valid
        end

        it "contains an invalid MID" do
          invalid_mmsi_number = "231#{random_mmsi_number[3..-1]}"
          vessel = build(:vessel, mmsi_number: invalid_mmsi_number)

          expect(vessel).not_to be_valid
        end
      end

      describe "radio call sign" do
        it "is not present" do
          vessel = build(:vessel, radio_call_sign: nil)
          expect(vessel).not_to be_valid
        end

        it "is less than 6 characters long" do
          invalid_radio_call_sign = random_radio_call_sign(5)
          vessel = build(:vessel, radio_call_sign: invalid_radio_call_sign)

          expect(vessel).not_to be_valid
        end

        it "is greater than 7 characters long" do
          invalid_radio_call_sign = random_radio_call_sign(8)
          vessel = build(:vessel, radio_call_sign: invalid_radio_call_sign)

          expect(vessel).not_to be_valid
        end

        it "is in an invalid format" do
          invalid_radio_call_sign = random_radio_call_sign(6).insert(2, "-")
          vessel = build(:vessel, radio_call_sign: invalid_radio_call_sign)

          expect(vessel).not_to be_valid
        end
      end
    end
  end
end
