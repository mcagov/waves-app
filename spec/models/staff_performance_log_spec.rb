require "rails_helper"

describe StaffPerformanceLog do
  context ".record" do
    let(:user) { create(:user) }

    let(:task) do
      create(:task, service_level: :premium, target_date: "11/11/2011")
    end

    subject do
      StaffPerformanceLog.record(task, :referred, user)
    end

    it { expect(subject.task).to eq(task) }
    it { expect(subject.activity.to_sym).to eq(:referred) }
    it { expect(subject.service_level.to_sym).to eq(:premium) }
    it { expect(subject.target_date).to eq("11/11/2011".to_date) }
    it { expect(subject.actioned_by).to eq(user) }
  end
end
