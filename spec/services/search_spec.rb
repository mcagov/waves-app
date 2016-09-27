require "rails_helper"

describe Search, type: :model do
  context ".by_vessel" do
    let(:vessel) { create(:register_vessel) }
    subject { Search.by_vessel(vessel.reg_no) }

    it { expect(subject).to include(vessel) }
  end

  context ".by_submission" do
    let(:submission) { create(:submission) }
    subject { Search.by_submission(submission.ref_no) }

    it { expect(subject).to include(submission) }
  end

  context ".similar_vessels" do
    let!(:same_name) { create(:register_vessel, name: "Celebrator Doppelbock") }
    let!(:same_mmsi) { create(:register_vessel, mmsi_number: "233878594") }
    let!(:blank_mmsi) { create(:register_vessel, mmsi_number: "") }
    let!(:different_mmsi) { create(:register_vessel, mmsi_number: rand(9)) }
    let!(:same_hin) { create(:register_vessel, hin: "foo") }
    let!(:blank_hin) { create(:register_vessel, hin: nil) }
    let!(:same_radio) { create(:register_vessel, radio_call_sign: "4RWO0K") }
    let!(:blank_radio) { create(:register_vessel, radio_call_sign: nil) }

    let!(:vessel) { create_unassigned_submission!.vessel }
    subject { Search.similar_vessels(vessel) }

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
