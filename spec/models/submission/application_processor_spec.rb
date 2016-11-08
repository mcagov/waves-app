require "rails_helper"

describe Submission::ApplicationProcessor do
  context "#run" do
    let(:submission) { create(:assigned_submission, task: task) }
    let(:registration_starts_at) { 1.week.ago }

    subject { described_class.run(submission, registration_starts_at) }

    context "new_registration" do
      let(:task) { :new_registration }

      before do
        expect_registry_builder
        expect_registration_builder
      end

      it { subject }
    end
  end
end

def expect_registry_builder
  expect(Builders::RegistryBuilder)
    .to receive(:create)
    .with(submission)
end

def expect_registration_builder
  expect(Builders::RegistrationBuilder)
    .to receive(:create)
    .with(submission, registration_starts_at)
end
