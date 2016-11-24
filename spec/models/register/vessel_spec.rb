require "rails_helper"

describe Register::Vessel do
  let!(:vessel) { create(:registered_vessel) }

  context ".create" do
    it "generates a vessel#reg_no" do
      expect(vessel.reg_no).to match(/SSR2[0-9]{5}/)
    end

    it "has a registry part" do
      expect(vessel.part).to be_present
    end
  end

  context "#current_registration" do
    let!(:current_reg) do
      create(
        :registration,
        vessel_id: vessel.id, registered_until: 1.year.from_now)
    end

    let!(:old_reg) do
      create(
        :registration,
        vessel_id: vessel.id, registered_until: 10.years.ago)
    end

    subject { vessel.current_registration }

    it { expect(subject).to eq(current_reg) }
  end

  context "#notification_list" do
    let!(:vessel) { build(:registered_vessel) }

    before do
      expect(Builders::NotificationListBuilder)
        .to receive(:for_registered_vessel)
        .with(vessel)
    end

    it { vessel.notification_list }
  end

  context "#registration_status" do
    let!(:vessel) { create(:registered_vessel) }
    subject { vessel.registration_status }

    context "with an active registration" do
      before do
        create(
          :registration,
          vessel_id: vessel.id, registered_until: 1.day.from_now)
      end

      it { expect(subject).to eq(:registered) }
    end

    context "with an expired registration" do
      before do
        create(
          :registration,
          vessel_id: vessel.id, registered_until: 1.week.ago)
      end

      it { expect(subject).to eq(:expired) }
    end

    context "without a registration" do
      it { expect(subject).to eq(:pending) }
    end
  end
end
