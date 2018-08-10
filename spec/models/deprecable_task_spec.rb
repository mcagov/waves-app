require "rails_helper"

describe DeprecableTask do
  context "#provisional_registration?" do
    subject { described_class.new(task_type).provisional_registration? }

    context ":provisional" do
      let(:task_type) { :provisional }

      it { expect(subject).to be_truthy }
    end

    context ":new_registration" do
      let(:task_type) { :new_registration }

      it { expect(subject).to be_falsey }
    end
  end

  context "#re_registration?" do
    subject { described_class.new(task_type).re_registration? }

    context ":new_registration" do
      let(:task_type) { :new_registration }

      it { expect(subject).to be_falsey }
    end

    context ":re_registration" do
      let(:task_type) { :re_registration }

      it { expect(subject).to be_truthy }
    end
  end
end
