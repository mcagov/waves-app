require "rails_helper"

describe Builders::RegistrationBuilder do
  context ".create" do
    before do
      described_class.create(
        submission, registered_vessel, "10/10/2012 12:23 PM".to_datetime)
    end

    let!(:submission) { create(:assigned_submission) }
    let!(:registered_vessel) { create(:registered_vessel) }
    let(:registration) { submission.registration }

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

    it "makes a snapshot of the vessel details" do
      expect(registration.vessel[:id]).to eq(registered_vessel.id)
    end

    it "records the submission_ref_no" do
      expect(registration.submission_ref_no).to eq(submission.ref_no)
    end
  end
end
