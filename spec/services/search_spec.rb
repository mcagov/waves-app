require "rails_helper"

describe Search, type: :model do
  context ".similar_vessels" do
    let!(:same_name) do
      create(:registered_vessel, name: "CELEBRATOR DOPPELBOCK")
    end

    let!(:same_mmsi) { create(:registered_vessel, mmsi_number: "233878594") }
    let!(:blank_mmsi) { create(:registered_vessel, mmsi_number: "") }
    let!(:different_mmsi) { create(:registered_vessel, mmsi_number: rand(9)) }
    let!(:same_hin) { create(:registered_vessel, hin: "foo") }
    let!(:blank_hin) { create(:registered_vessel, hin: nil) }
    let!(:same_radio) { create(:registered_vessel, radio_call_sign: "4RWO0K") }
    let!(:blank_radio) { create(:registered_vessel, radio_call_sign: nil) }

    let!(:vessel) { create_submission_from_api!.vessel }
    subject { Search.similar_vessels(:part_3, vessel) }

    it "contains the same_name" do
      expect(subject).to include(same_name)
    end

    it "contains the same_mmsi" do
      expect(subject).to include(same_mmsi)
    end

    it "does not contain the different_mmsi" do
      expect(subject).not_to include(different_mmsi)
    end

    it "does not contain the blank_mmsi" do
      expect(subject).not_to include(blank_mmsi)
    end

    it "contains the same_hin" do
      expect(subject).to include(same_mmsi)
    end

    it "contains the blank_hin" do
      expect(subject).not_to include(blank_hin)
    end

    it "contains the same_radio_call_sign" do
      expect(subject).to include(same_radio)
    end

    it "does not contain the different_mmsi" do
      expect(subject).not_to include(different_mmsi)
    end
  end
end
