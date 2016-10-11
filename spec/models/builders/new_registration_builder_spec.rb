require "rails_helper"

describe Builders::NewRegistrationBuilder do
  context ".create" do
    let!(:submission) { create_assigned_submission! }
    let(:registration) { described_class.create(submission) }

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
        .to eq(Date.today)
    end

    it "creates the five year registration" do
      expect(registration.registered_until)
        .to eq(registration.created_at.advance(years: 5).to_date)
    end

    it "sets the registration#actioned_by" do
      expect(registration.actioned_by)
        .to eq(submission.claimant)
    end
  end
end
