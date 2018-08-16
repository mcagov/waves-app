require "rails_helper"

describe Builders::ClosedRegistrationBuilder do
  context ".create" do
    let(:task) do
      create(:task,
             submission: create(:submission, :part_3_vessel))
    end

    subject do
      described_class.create(
        task,
        "10/10/2012 12:23 PM".to_datetime,
        "Mi Razon",
        "additional details")
    end

    it "records the closed_at date" do
      expect(subject.closed_at).to eq("10/10/2012 12:23 PM".to_datetime)
    end

    it "records the closure reason" do
      expect(subject.description).to eq("Mi Razon")
    end

    it "records the supporting_info" do
      expect(subject.supporting_info).to eq("additional details")
    end

    it "records the registration#actioned_by" do
      expect(subject.actioned_by).to eq(task.claimant)
    end

    it "assigns the submission#registration" do
      expect(subject).to eq(Submission.last.registration)
    end

    it "assigns the registered_vessel#current_registration" do
      expect(subject).to eq(Register::Vessel.last.current_registration)
    end
  end
end
