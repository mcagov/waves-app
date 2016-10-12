require "rails_helper"

describe Builders::NewRegistrationBuilder do
  context ".create" do
    let!(:submission) { create_assigned_submission! }
    let(:registration) do
      described_class.create(submission, "10/10/2012 12:23 PM".to_datetime)
    end

    it "creates the expected vessel type" do
      expect(registration.vessel.vessel_type).to eq("BARGE")
    end

    it "creates the owners" do
      expect(
        registration.vessel.owners.length
      ).to eq(2)
    end

    it "records the registration date" do
      expect(registration.registered_at)
        .to eq("10/10/2012 12:23 PM".to_datetime)
    end

    it "creates the five year registration" do
      expect(registration.registered_until)
        .to eq("10/10/2017 12:23 PM".to_datetime)
    end

    it "sets the registration#actioned_by" do
      expect(registration.actioned_by)
        .to eq(submission.claimant)
    end
  end
end
