require "rails_helper"

describe Builders::RegistrationBuilder do
  context ".create" do
    let(:task) do
      create(:claimed_task,
             service: create(:service, :generate_new_5_year_registration))
    end

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

      it "sets the vessel#current_registration" do
        expect(subject).to eq(registered_vessel.reload.current_registration)
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

    context "when the dates are blank" do
      subject do
        described_class.create(task, registered_vessel, "", nil, false)
      end

      it { expect(subject).to be_persisted }
      it { expect(subject.registered_at).to be_present }
      it { expect(subject.registered_until).to be_present }
    end
  end
end
