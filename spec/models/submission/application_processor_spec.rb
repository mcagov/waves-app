require "rails_helper"

describe Submission::ApplicationProcessor do
  context "#run" do
    subject { described_class.run(submission, registration_starts_at) }

    context "a new_registration" do
      let(:submission) { create(:assigned_submission) }
      let(:registration_starts_at) { 1.week.ago }

      before do
        expect(Builders::RegistryBuilder)
          .to receive(:create)
          .with(submission)

        expect(Builders::RegistrationBuilder)
          .to receive(:create)
          .with(submission, registration_starts_at)
      end

      it { subject }
    end

    it "checks behaviour of other tasks"
  end
end
