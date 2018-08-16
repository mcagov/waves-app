require "rails_helper"

describe ServiceStandard do
  context ".status" do
    before do
      expect(TargetDate)
        .to receive(:days_away)
        .with(task.target_date)
        .and_return(days_away)
    end

    let(:task) { create(:task) }

    subject { described_class.status(task) }

    context "3 days away" do
      let(:days_away) { 3 }

      it { expect(subject).to eq(:green) }
    end

    context "tomorrow" do
      let(:days_away) { 1 }

      it { expect(subject).to eq(:amber) }
    end

    context "today" do
      let(:days_away) { 0 }

      it { expect(subject).to eq(:amber) }
    end

    context "yesterday" do
      let(:days_away) { -1 }

      it { expect(subject).to eq(:red) }
    end
  end
end
