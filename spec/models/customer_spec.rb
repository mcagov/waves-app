require "rails_helper"

describe Customer do
  let!(:customer) { build(:customer) }

  context "in general" do
    it { expect(customer.to_s).to eq("Bob") }

    it do
      expect(customer.details)
        .to eq(name: "Bob", inline_address: customer.inline_address)
    end
  end
end
