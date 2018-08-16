require "rails_helper"

describe Builders::RegistrationBuilder do
  context ".create" do
    let(:task) { create(:claimed_task) }
    let(:registered_vessel) { create(:registered_vessel) }

    context "in general" do
      subject do
        described_class.create(
          task,
          registered_vessel,
          "10/10/2012 12:23 PM".to_datetime,
          "10/10/2017 12:23 PM".to_datetime,
          false)
      end

      it "records the registration date" do
        expect(subject.registered_at)
          .to eq("10/10/2012 12:23 PM".to_datetime)
      end

      it "creates the five year registration" do
        expect(subject.registered_until)
          .to eq("10/10/2017 12:23 PM".to_datetime)
      end

      it "sets the registration#actioned_by" do
        expect(subject.actioned_by)
          .to eq(task.claimant)
      end

      it "makes a snapshot of the vessel details" do
        expect(subject.vessel[:id]).to eq(registered_vessel.id)
      end

      it "sets the submission#registration" do
        expect(subject).to eq(task.reload.submission.registration)
      end

      it { expect(subject).not_to be_provisional }
    end

    context "with the provisional parameter" do
      subject do
        described_class.create(
          task,
          registered_vessel,
          "10/10/2012 12:23 PM".to_datetime,
          "10/10/2017 12:23 PM".to_datetime,
          true)
      end

      it { expect(subject).to be_provisional }
    end
  end
end
