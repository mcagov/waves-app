require "rails_helper"

describe "Service" do
  let(:service) { create(:demo_service) }

  context "#standard_price(part)" do
    it { expect(service.standard_price(:part_1)).to eq(12400) }
    it { expect(service.standard_price(:part_2)).to be_blank }
    it { expect(service.standard_price(:part_3)).to eq(2500) }
    it { expect(service.standard_price(:part_4)).to eq(12400) }
  end

  context "#premium_supplement(part)" do
    it { expect(service.premium_supplement(:part_1)).to eq(18000) }
    it { expect(service.premium_supplement(:part_2)).to be_blank }
    it { expect(service.premium_supplement(:part_3)).to eq(5000) }
    it { expect(service.premium_supplement(:part_4)).to eq(18000) }
  end

  context "#subsequent_price(part)" do
    it { expect(service.subsequent_price(:part_1)).to eq(9900) }
    it { expect(service.subsequent_price(:part_2)).to be_blank }
    it { expect(service.subsequent_price(:part_3)).to be_blank }
    it { expect(service.subsequent_price(:part_4)).to be_blank }
  end
end
