require "rails_helper"

describe Register::Vessel do
  let!(:vessel) { create(:register_vessel) }

  context ".create" do
    it "generates a vessel#reg_no" do
      expect(vessel.reg_no).to match(/SSR2[0-9]{5}/)
    end
  end

  context "#latest_registration" do
    let!(:current_reg) do
      create(:registration, vessel: vessel, registered_until: 1.year.from_now)
    end

    let!(:old_reg) do
      create(:registration, vessel: vessel, registered_until: 10.years.ago)
    end

    subject { vessel.latest_registration }

    it { expect(subject).to eq(current_reg) }
  end
end
