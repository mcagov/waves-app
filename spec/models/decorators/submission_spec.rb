require "rails_helper"

describe Decorators::Submission, type: :model do
  context "#editable?" do
    let(:submission) { Submission.new(state: submission_state, part: :part_3) }
    subject { described_class.new(submission).editable? }

    context "when the state is completed" do
      let(:submission_state) { :completed }

      it { expect(subject).to be_falsey }
    end

    context "when the state is something else" do
      let(:submission_state) { "" }

      it { expect(subject).to be_truthy }
    end
  end

  context "#notification_list" do
    let!(:submission) { build(:submission) }

    before do
      expect(Builders::NotificationListBuilder)
        .to receive(:for_submission)
        .with(submission)
    end

    it { described_class.new(submission).notification_list }
  end

  context "#vessel_can_be_edited?" do
    let!(:submission) { build(:submission) }

    before do
      task = double(:task)

      expect(Task).to receive(:new).with(submission.task).and_return(task)
      expect(task).to receive(:vessel_can_be_edited?)
    end

    it { described_class.new(submission).vessel_can_be_edited? }
  end

  context "#ownership_can_be_changed?" do
    let!(:submission) { build(:submission) }

    before do
      task = double(:task)

      expect(Task).to receive(:new).with(submission.task).and_return(task)
      expect(task).to receive(:ownership_can_be_changed?)
    end

    it { described_class.new(submission).ownership_can_be_changed? }
  end

  context "#address_can_be_changed?" do
    let!(:submission) { build(:submission) }

    before do
      task = double(:task)

      expect(Task).to receive(:new).with(submission.task).and_return(task)
      expect(task).to receive(:address_can_be_changed?)
    end

    it { described_class.new(submission).address_can_be_changed? }
  end

  context "#delivery_description" do
    before do
      allow(submission)
        .to receive(:electronic_delivery?).and_return(electronic_delivery)
    end

    let!(:submission) { build(:submission) }
    subject { described_class.new(submission).delivery_description }

    context "with electronic_delivery" do
      let(:electronic_delivery) { true }

      it { expect(subject).to eq("Electronic delivery") }
    end

    context "without electronic_delivery" do
      let(:electronic_delivery) { false }

      it { expect(subject).to match(/BOB DOLE, 11 DOWNING ST/) }
    end
  end

  context "#vessel_attribute_changed?" do
    subject do
      described_class.new(submission).vessel_attribute_changed?(:name)
    end

    context "for a new registration" do
      let(:submission) { build(:submission, task: :new_registration) }
      it { expect(subject).to be_falsey }
    end

    context "when there is a registered_vessel" do
      context "when the name has not been changed" do
        let(:submission) { create(:unassigned_change_vessel_submission) }
        it { expect(subject).to be_falsey }
      end

      context "when the name has been changed" do
        let(:submission) do
          create(
            :unassigned_change_vessel_submission,
            changeset: { vessel_info: { name: "NEW NAME" } })
        end

        it { expect(subject).to be_truthy }
      end
    end
  end

  context "#tonnage_defined?" do
    let(:submission) do
      build(:submission, changeset: { vessel_info: vessel_info })
    end

    subject { described_class.new(submission).tonnage_defined? }

    context "when tonnage has not been defined" do
      let(:vessel_info) { {} }

      it { expect(subject).to be_falsey }
    end

    context "when new_tonnage has been defined" do
      let(:vessel_info) { { net_tonnage: 100 } }

      it { expect(subject).to be_truthy }
    end

    context "when register_tonnage has been defined" do
      let(:vessel_info) { { register_tonnage: 100 } }

      it { expect(subject).to be_truthy }
    end
  end

  context "#can_issue_carving_and_marking?" do
    let(:decorated_submission) { described_class.new(create(:submission)) }
    subject { decorated_submission.can_issue_carving_and_marking? }

    context "when it can" do
      before do
        expect(decorated_submission)
          .to receive(:tonnage_defined?).and_return(true)

        expect(decorated_submission)
          .to receive(:vessel_reg_no).and_return(true)
      end

      it { expect(subject).to be_truthy }
    end

    context "when it has no vessel_reg_no" do
      before do
        expect(decorated_submission)
          .to receive(:tonnage_defined?).and_return(true)

        expect(decorated_submission)
          .to receive(:vessel_reg_no).and_return(false)
      end

      it { expect(subject).to be_falsey }
    end

    context "when it has no tonnage" do
      before do
        expect(decorated_submission)
          .to receive(:tonnage_defined?).and_return(false)
      end

      it { expect(subject).to be_falsey }
    end
  end

  context "#service_level" do
    it "prefers the service_level as :standard over is_urgent?"
  end
end
