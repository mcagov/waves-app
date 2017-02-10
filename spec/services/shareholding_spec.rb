require "rails_helper"

describe ShareHolding do
  context "in general" do
    let(:share_holding) { ShareHolding.new(double(:submission)) }
    before do
      allow(share_holding).to receive(:total).and_return(total_shares)
    end

    context "with too few shares" do
      let("total_shares") { 12 }
      it { expect(share_holding.status).to eq(:incomplete) }
      it { expect(share_holding.unallocated).to eq(52) }
    end

    context "with the correct number of shares" do
      let("total_shares") { 64 }
      it { expect(share_holding.status).to eq(:complete) }
      it { expect(share_holding.unallocated).to eq(0) }
    end

    context "with too many shares" do
      let("total_shares") { 65 }
      it { expect(share_holding.status).to eq(:excessive) }
    end
  end
end
