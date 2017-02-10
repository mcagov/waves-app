require "rails_helper"

describe ShareHolding do
  context ".status" do
    let(:share_holding) { ShareHolding.new(double(:submission)) }
    before do
      allow(share_holding).to receive(:total).and_return(total_shares)
    end

    subject { share_holding.status }

    context "with too few shares" do
      let("total_shares") { 12 }
      it { expect(subject).to eq(:incomplete) }
    end

    context "with the correct number of shares" do
      let("total_shares") { 64 }
      it { expect(subject).to eq(:complete) }
    end

    context "with too many shares" do
      let("total_shares") { 65 }
      it { expect(subject).to eq(:excessive) }
    end
  end
end
