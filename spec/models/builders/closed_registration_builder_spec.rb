require "rails_helper"

describe Builders::ClosedRegistrationBuilder do
  context ".create" do
    before do
      allow(registered_vessel)
        .to receive(:current_registration)
        .and_return(current_registration)

      described_class.create(
        submission,
        "10/10/2012 12:23 PM".to_datetime,
        "Mi Razon")
    end

    let!(:registered_vessel) { create(:registered_vessel) }

    let!(:current_registration) do
      create(:registration,
             registered_at: 1.year.ago, registered_until: 4.years.from_now)
    end

    let!(:submission) do
      create(:submission,
             registered_vessel: registered_vessel, task: :closure)
    end

    let(:registration) { submission.reload.registration }

    it "records the closed_at date" do
      expect(registration.closed_at).to eq("10/10/2012 12:23 PM".to_datetime)
    end

    it "records the closure reason" do
      expect(registration.description).to eq("Mi Razon")
    end

    it "records the registration#actioned_by" do
      expect(registration.actioned_by).to eq(submission.claimant)
    end
  end
end
