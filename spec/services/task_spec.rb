require "rails_helper"

describe Task do
  let(:task) { described_class.new(key) }

  context "#description" do
    subject { task.description }

    context "of a new_registration" do
      let(:key) { :new_registration }
      it { expect(subject).to eq("New Registration") }
    end

    context "of a change_vessel" do
      let(:key) { :change_vessel }
      it { expect(subject).to eq("Change of Vessel details") }
    end
  end

  context "#payment_required?" do
    subject { task.payment_required? }

    context "for a new_registration" do
      let(:key) { :new_registration }
      it { expect(subject).to be_truthy }
    end

    context "for a closure" do
      let(:key) { [:closure, :change_address].sample }
      it { expect(subject).to be_falsey }
    end
  end

  context "#prints_certificate?" do
    subject { task.prints_certificate? }

    context "for a renewal" do
      let(:key) { :new_registration }
      it { expect(subject).to be_truthy }
    end

    context "for a transcript" do
      let(:key) { :transcript }
      it { expect(subject).to be_falsey }
    end
  end

  context ".finance_task_types" do
    it do
      [:change_address, :closure].each do |task_type|
        expect(Task.finance_task_types).not_to include(task_type)
      end
    end
  end

  context ".default_task_types" do
    it do
      [:reserve_name, :unknown].each do |task_type|
        expect(Task.default_task_types).not_to include(task_type)
      end
    end
  end
end
