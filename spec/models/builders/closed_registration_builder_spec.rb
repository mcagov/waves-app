require "rails_helper"

describe Builders::ClosedRegistrationBuilder do
  context ".create" do
    before do
      allow(registered_vessel)
        .to receive(:current_registration)
        .and_return(previous_registration)

      described_class.create(
        submission,
        "10/10/2012 12:23 PM".to_datetime,
        "Mi Razon")
    end

    let!(:registered_vessel) { create(:registered_vessel) }

    let!(:previous_registration) do
      create(:registration,
             registered_at: 1.year.ago, registered_until: 4.years.from_now)
    end

    let!(:submission) do
      create(:submission,
             registered_vessel: registered_vessel, task: :closure)
    end

    let(:registration) do
      Registration.find_by(submission_ref_no: submission.ref_no)
    end

    it "records the closed_at date" do
      expect(registration.closed_at).to eq("10/10/2012 12:23 PM".to_datetime)
    end

    it "records the closure reason" do
      expect(registration.description).to eq("Mi Razon")
    end

    it "records the registration#actioned_by" do
      expect(registration.actioned_by).to eq(submission.claimant)
    end

    it "records a snapshot of the vessel details" do
      expect(registration.vessel[:id]).to eq(registered_vessel.id)
    end

    it "records the submission_ref_no" do
      expect(registration.submission_ref_no).to eq(submission.ref_no)
    end

    it "records the task" do
      expect(registration.task).to eq(submission.task)
    end

    it "records the previous registration dates" do
      expect(registration.registered_at.to_date)
        .to eq(previous_registration.registered_at.to_date)

      expect(registration.registered_until.to_date)
        .to eq(previous_registration.registered_until.to_date)
    end
  end
end
