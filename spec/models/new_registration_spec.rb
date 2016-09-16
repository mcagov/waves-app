require "rails_helper"

describe NewRegistration, type: :model do
  let!(:new_registration) { create_assigned_submission! }

  context "in general" do
    it "has a ref_no with the expected prefix" do
      expect(new_registration.ref_no).to match(/3N-.*/)
    end
  end

  context "#process_application!" do
    before { new_registration.process_application }

    it "creates a vessel" do
      expect(new_registration.registered_vessel).to be_present
    end

    it "creates the registered_owners" do
      expect(
        new_registration.registered_vessel.registered_owners.length
      ).to eq(2)
    end

    it "creates the one year registration" do
      expect(new_registration.registration.registered_at)
        .to eq(Date.today)
      expect(new_registration.registration.registered_until)
        .to eq(Date.today.advance(days: 364))
    end

    it "sets the registration#actioned_by" do
      expect(new_registration.registration.actioned_by)
        .to eq(new_registration.claimant)
    end
  end

  context "#similar_vessels" do
    let!(:same_name) { create(:vessel, name: "Celebrator Doppelbock") }

    let!(:same_mmsi) { create(:vessel, mmsi_number: "233878594") }
    let!(:blank_mmsi) { create(:vessel, mmsi_number: "") }
    let!(:different_mmsi) { create(:vessel, mmsi_number: rand(9)) }

    let!(:same_hin) { create(:vessel, hin: "foo") }
    let!(:blank_hin) { create(:vessel, hin: nil) }

    let!(:same_radio) { create(:vessel, radio_call_sign: "4RWO0K") }
    let!(:blank_radio) { create(:vessel, radio_call_sign: nil) }

    subject { new_registration.similar_vessels }

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
