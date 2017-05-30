require "rails_helper"

describe Builders::RegistrationBuilder do
  context ".create" do
    context "with a task for a registered_vessel" do
      let!(:registered_vessel) { create(:registered_vessel) }
      let(:submission) do
        create(:assigned_submission,
               task: task,
               registered_vessel: registered_vessel)
      end

      before do
        described_class.create(
          submission, registered_vessel, "10/10/2012 12:23 PM".to_datetime)
      end

      let(:registration) { submission.registration }

      context "with a change_vessel task" do
        let(:task) { :change_vessel }

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

        it { expect(registration).not_to be_provisional }
      end

      context "with a provisional_registration task" do
        let(:task) { :provisional }

        it { expect(registration).to be_provisional }
      end
    end
  end
end
