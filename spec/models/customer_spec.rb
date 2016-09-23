require "rails_helper"

describe Customer do
  subject { build(:customer) }

  context "in general" do
    it { expect(subject.to_s).to eq("Bob") }

    it do
      expect(subject.inline_address)
        .to eq("10 Downing St, Whitehall, London, UNITED KINDOM, W1 1AA")
    end
  end
end
