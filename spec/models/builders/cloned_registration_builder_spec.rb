require "rails_helper"

describe Builders::ClonedRegistrationBuilder do
  context ".create" do
    before do
      allow(registered_vessel)
        .to receive(:current_registration)
        .and_return(current_registration)

      described_class.create(submission)
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

    it "assigns the submission#registration" do
      expect(submission.registration).to eq(current_registration)
    end
  end
end
