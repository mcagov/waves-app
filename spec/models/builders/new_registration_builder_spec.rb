require "rails_helper"

describe Builders::NewRegistrationBuilder do
  context ".create" do
    before do
      described_class.create(submission, "10/10/2012 12:23 PM".to_datetime)
    end

    let!(:submission) { create_assigned_submission! }
    let(:registration) { submission.registration }

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

    it "builds the print_jobs" do
      expect(submission.print_jobs.symbolize_keys)
        .to eq(registration_certificate: false, cover_letter: false)
    end

    it "associates the submission with the registered_vessel" do
      expect(submission.registered_vessel).to eq(Register::Vessel.last)
    end

    it "creates registered owners in the expect order" do
      expect(submission.owners.first.name)
        .to eq(registration.vessel.owners.first.name)

      expect(submission.owners.last.name)
        .to eq(registration.vessel.owners.last.name)
    end
  end
end
