require "rails_helper"

describe "Service" do
  let(:service) { create(:demo_service) }

  context "#standard_price(part)" do
    it { expect(service.standard_price(:part_1)).to eq(124) }
    it { expect(service.standard_price(:part_2)).to be_blank }
    it { expect(service.standard_price(:part_3)).to eq(25) }
    it { expect(service.standard_price(:part_4)).to eq(124) }
  end

  context "#premium_supplement(part)" do
    it { expect(service.premium_supplement(:part_1)).to eq(180) }
    it { expect(service.premium_supplement(:part_2)).to be_blank }
    it { expect(service.premium_supplement(:part_3)).to eq(50) }
    it { expect(service.premium_supplement(:part_4)).to eq(180) }
  end

  context "#subsequent_price(part)" do
    it { expect(service.subsequent_price(:part_1)).to eq(99) }
    it { expect(service.subsequent_price(:part_2)).to be_blank }
    it { expect(service.subsequent_price(:part_3)).to be_blank }
    it { expect(service.subsequent_price(:part_4)).to be_blank }
  end
end
