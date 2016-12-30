require "rails_helper"

describe Search, type: :model do
  context ".all" do
    before do
      expect(PgSearch)
        .to receive(:multisearch).with("foo")
    end

    it { Search.all("foo") }
  end

  context ".submissions" do
    context "search by vessel name" do
      let!(:submission) { create(:assigned_change_vessel_submission) }

      subject { Search.submissions(submission.vessel.name.slice(0, 3)) }

      it { expect(subject.first).to eq(submission) }
    end

    context "search by submission ref_no" do
      let!(:submission) { create(:assigned_submission) }

      subject { Search.submissions(submission.ref_no.slice(0, 3)) }

      it { expect(subject.first).to eq(submission) }
    end
  end

  context ".vessels" do
    context "search by vessel name" do
      let!(:vessel) { create(:registered_vessel, name: "BOBS BOAT") }

      subject { Search.vessels("BOB") }

      it { expect(subject.first).to eq(vessel) }
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
