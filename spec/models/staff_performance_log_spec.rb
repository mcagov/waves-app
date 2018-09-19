require "rails_helper"

describe StaffPerformanceLog do
  context ".record" do
    let(:user) { create(:user) }

    let(:task) do
      create(:task, service_level: :premium, target_date: target_date)
    end

    subject do
      StaffPerformanceLog.record(task, :referred, user)
    end

    context "in general" do
      let(:target_date) { 1.day.ago }

      it { expect(subject.task).to eq(task) }
      it { expect(subject.activity.to_sym).to eq(:referred) }
      it { expect(subject.service_level.to_sym).to eq(:premium) }
      it { expect(subject.target_date).to eq(target_date.to_date) }
      it { expect(subject.actioned_by).to eq(user) }
      it { expect(subject.within_standard).to be_falsey }
      it { expect(subject.part.to_sym).to eq(:part_3) }
    end

    context "when the service standard is met - TODAY" do
      let(:target_date) { Date.current }

      it { expect(subject.within_standard).to be_truthy }
    end

    context "when the service standard is met - TOMORROW" do
      let(:target_date) { 1.day.from_now }

      it { expect(subject.within_standard).to be_truthy }
    end
  end
end
