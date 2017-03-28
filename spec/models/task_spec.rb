require "rails_helper"

describe Task do
  context "#new_registration?" do
    subject { described_class.new(task_type).new_registration? }

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
end
