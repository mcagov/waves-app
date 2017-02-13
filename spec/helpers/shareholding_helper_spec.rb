require "rails_helper"
include ShareholdingHelper

describe "ShareholdingHelper" do
  describe ".share_allocation_message" do
    let!(:shareholding) { double(:shareholding) }

    subject { helper.share_allocation_message(shareholding) }

    context "is incomplete" do
      before do
        allow(shareholding).to receive(:status).and_return(:incomplete)
        allow(shareholding).to receive(:unallocated).and_return(2)
      end

      it { expect(subject).to match("2 shares un-allocated") }
    end

    context "is excessive" do
      before do
        allow(shareholding).to receive(:status).and_return(:excessive)
      end

      it { expect(subject).to match("Invalid share allocation") }
    end

    context "is complete" do
      before do
        allow(shareholding).to receive(:status).and_return(:complete)
      end

      it { expect(subject).to be_blank }
    end
  end
end
