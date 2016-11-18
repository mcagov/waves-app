require "rails_helper"

describe Submission::ApplicationProcessor do
  context "#run" do
    let(:registration_starts_at) { 1.week.ago }

    subject { described_class.run(submission, registration_starts_at) }

    context "new_registration" do
      let(:task) { :new_registration }
      let(:submission) { create(:submission) }

      before do
        expect_registry_builder
        expect_registration_builder
      end

      it { subject }
    end

    context "with a registered_vessel" do
      let(:submission) do
        create(:assigned_submission,
               task: task, registered_vessel: create(:registered_vessel))
      end

      context "change_vessel" do
        let(:task) { :change_vessel }

        before do
          expect_registry_builder
          expect_registration_builder
        end

        it { subject }
      end

      context "change_address" do
        let(:task) { :change_address }

        before do
          expect_registry_builder
          dont_expect_registration_builder
        end

        it { subject }
      end

      context "duplicate_certificate" do
        let(:task) { :duplicate_certificate }

        before do
          dont_expect_registry_builder
          expect_registration_builder
        end

        it { subject }
      end

      context "renewal" do
        let(:task) { :renewal }

        before do
          expect_registry_builder
          expect_registration_builder
        end

        it { subject }
      end

      context "closure" do
        let(:task) { :closure }

        before do
          dont_expect_registry_builder
          dont_expect_registration_builder
        end

        it { subject }
      end

      context "transcript" do
        let(:task) { :closure }

        before do
          dont_expect_registry_builder
          dont_expect_registration_builder
        end

        it { subject }
      end
    end
  end
end

def expect_registry_builder
  expect(Builders::RegistryBuilder)
    .to receive(:create)
    .with(submission)
end

def dont_expect_registry_builder
  expect(Builders::RegistryBuilder).not_to receive(:create)
end

def expect_registration_builder
  expect(Builders::RegistrationBuilder)
    .to receive(:create)
    .with(submission, registration_starts_at)
end

def dont_expect_registration_builder
  expect(Builders::RegistrationBuilder).not_to receive(:create)
end
