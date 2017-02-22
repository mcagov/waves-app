require "rails_helper"

describe Engine do
  context "#total_mcep" do
    let!(:engine) do
      Engine.create(
        parent: build(:submission),
        mcep_after_derating: mcep,
        quantity: quantity)
    end

    subject { engine.total_mcep }

    context "with valid data, the result is rounded to 2 decimal places" do
      let(:mcep) { 300.34 }
      let(:quantity) { 3 }
      it { expect(subject).to eq(901.02) }
    end

    context "with invalid data, the result is 0" do
      let(:mcep) { nil }
      let(:quantity) { nil }
      it { expect(subject).to eq(0) }
    end
  end

  context ".total_mcep_for(submission)" do
    let(:submission) { create(:submission) }
    subject { described_class.total_mcep_for(submission) }

    before do
      submission.engines.create(mcep_after_derating: 300.34, quantity: 3)
      submission.engines.create(mcep_after_derating: 0, quantity: 3)
      submission.engines.create(mcep_after_derating: 1000.17, quantity: 18)
    end

    it { expect(subject.round(2)).to eq(18904.08) }
  end
end
