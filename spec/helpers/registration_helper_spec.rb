require "rails_helper"

describe RegistrationHelper, type: :helper do

  describe "#inline_address" do
    it "renders an inline address" do
      expect(inline_address(sample_address)).to eq("10 Downing Street, Cardiff, GB, W4 NKR")
    end
  end
end

def sample_address
  {
    address_1: "10 Downing Street",
    address_2: "",
    address_3: nil,
    town: "Cardiff",
    county: "",
    country: "GB",
    postcode: "W4 NKR"
  }
end
