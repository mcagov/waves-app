require "rails_helper"

describe Register::Vessel do
  context ".create" do
    let!(:vessel) { create(:register_vessel) }

    it "generates a vessel#reg_no" do
      expect(vessel.reg_no).to match(/SSR2[0-9]{5}/)
    end
  end
end
