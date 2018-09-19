require "rails_helper"

describe Submission, type: :model do
  context "in general" do
    let!(:submission) { create(:submission) }

    it "gets the vessel_info" do
      expect(submission.vessel).to be_a(Submission::Vessel)
    end

    it "gets the delivery_address" do
      expect(submission.delivery_address.country).to eq("UNITED KINGDOM")
    end
  end

  context ".create" do
    let(:submission) { Submission.create }

    it "defaults to source = online" do
      expect(submission.source.to_sym).to eq(:online)
    end

    it "defaults to part = part_3" do
      expect(submission.part.to_sym).to eq(:part_3)
    end

    it "builds the ref_no" do
      expect(submission.ref_no).to be_present
    end
  end

  describe "#close!" do
    let(:submission) { create(:submission) }

    before do
      tasks = double(:tasks, active: active_tasks, initialising: [])
      allow(submission).to receive(:tasks).and_return(tasks)
    end

    subject { submission.close! }

    context "with active tasks" do
      let(:active_tasks) { [1] }

      it { expect(subject).to be_falsey }
    end

    context "without active tasks" do
      let(:active_tasks) { [] }

      it { expect(subject).to be_truthy }
    end
  end

  context ".vessel_reg_no =" do
    let!(:registered_vessel) { create(:registered_vessel, part: vessel_part) }
    let(:submission) { create(:submission, part: :part_1) }

    before { submission.vessel_reg_no = registered_vessel.reg_no }

    context "for a part_1 submission and a part_1 registered_vessel" do
      let(:vessel_part) { :part_1 }

      it { expect(submission.registered_vessel).to eq(registered_vessel) }
    end

    context "for a part_2 submission and a part_1 registered_vessel" do
      let(:vessel_part) { :part_2 }

      it { expect(submission.registered_vessel).to be_nil }
    end
  end

  context "#vessel_name" do
    subject { submission.vessel_name }

    context "with a registered_vessel and an empty changeset" do
      let(:submission) { build(:submission, :part_3_vessel, changeset: {}) }

      it { expect(subject).to eq(submission.registered_vessel.name) }
    end

    context "with a vessel name in the changeset" do
      let(:submission) { build(:submission) }

      it { expect(subject).to eq(submission.vessel.name) }
    end

    context "with a vessel name in a finance payment entry" do
      let(:submission) do
        create(:locked_finance_payment, vessel_name: "FP BOAT")
      end

      it { expect(subject).to eq("FP BOAT") }
    end

    context "with no vessel name" do
      let(:submission) { Submission.new }

      it { expect(subject).to eq("UNKNOWN") }
    end
  end

  context ".registered_vessel_exists" do
    let!(:submission) { build(:submission) }

    before do
      allow(Policies::Actions)
        .to receive(:registered_vessel_required?)
        .with(submission)
        .and_return(registered_vessel_required_policy)

      submission.save
    end

    context "when the registered_vessel_required? policy returns true" do
      let(:registered_vessel_required_policy) { true }

      it { expect(submission.errors).to include(:vessel_reg_no) }

      context "and the submission has a registered_vessel" do
        before do
          submission.vessel_reg_no = create(:registered_vessel).reg_no
        end

        it { expect(submission).to be_valid }
      end
    end

    context "when the registered_vessel_required? policy returns false" do
      let(:registered_vessel_required_policy) { false }

      it { expect(submission).to be_valid }
    end
  end

  context "#notification_list" do
    let!(:submission) { build(:submission) }

    before do
      expect(Builders::NotificationListBuilder)
        .to receive(:for_submission)
        .with(submission)
    end

    it { submission.notification_list }
  end

  context "#applicant" do
    let(:submission) do
      build(:submission,
            applicant_name: "ALICE",
            applicant_email: "alice@example.com")
    end

    subject { submission.applicant }

    it { expect(subject.email).to eq("alice@example.com") }
    it { expect(subject.name).to eq("ALICE") }
  end
end
