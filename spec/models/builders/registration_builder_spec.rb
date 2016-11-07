require "rails_helper"

describe Builders::RegistrationBuilder do
  context ".create" do
    before do
      described_class.create(submission, "10/10/2012 12:23 PM".to_datetime)
    end

    let!(:submission) { create(:assigned_submission) }
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
  end
end
