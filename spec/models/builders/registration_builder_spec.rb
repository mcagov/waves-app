require "rails_helper"

describe Builders::RegistrationBuilder do
  context ".create" do
    before do
      described_class.create(
        submission, registered_vessel, "10/10/2012 12:23 PM".to_datetime)
    end

    let!(:registered_vessel) { create(:registered_vessel) }
    let!(:submission) do
      create(:assigned_submission,
             task: :change_vessel,
             registered_vessel: registered_vessel)
    end

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

    it "makes a snapshot of the vessel details" do
      expect(registration.vessel[:id]).to eq(registered_vessel.id)
    end

    it "sets the submission#registration" do
      expect(submission.registration).to eq(registration)
    end
  end
end
