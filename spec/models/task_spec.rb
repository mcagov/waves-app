require "rails_helper"

describe Task do
  let(:task) { described_class.new(task_type) }

  context "#new_registration?" do
    subject { task.new_registration? }

    context ":new_registration" do
      let(:task_type) { :new_registration }

      it { expect(subject).to be_truthy }
    end

    context ":provisional" do
      let(:task_type) { :provisional }

      it { expect(subject).to be_truthy }
    end

    context ":renewal" do
      let(:task_type) { :renewal }

      it { expect(subject).to be_falsey }
    end
  end

  context "#display_changeset?" do
    subject { task.display_changeset? }

    context ":re_registration" do
      let(:task_type) { :re_registration }

      it { expect(subject).to be_falsey }
    end

    context ":new_registration" do
      let(:task_type) { :new_registration }

      before do
        expect(task).to receive(:builds_registry?)
      end

      it { subject }
    end

    context ":vessel_details" do
      let(:task_type) { :vessel_details }

      before do
        expect(task).to receive(:builds_registry?)
      end

      it { subject }
    end
  end
end
