require "rails_helper"

describe Search, type: :model do
  context ".by_vessel" do
    let(:registered_vessel) { create(:registered_vessel) }
    subject { Search.by_vessel(part, registered_vessel.reg_no) }

    context "in part_3" do
      let(:part) { :part_3 }
      it { expect(subject).to include(registered_vessel) }
    end

    context "in part_x" do
      let(:part) { :part_x }
      it { expect(subject).to be_empty }
    end
  end

  context ".by_submission" do
    let(:submission) { create(:submission) }
    subject { Search.by_submission(part, submission.ref_no) }

    context "in part_3" do
      let(:part) { :part_3 }
      it { expect(subject).to include(submission) }
    end

    context "in part_x" do
      let(:part) { :part_x }
      it { expect(subject).to be_empty }
    end
  end

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
