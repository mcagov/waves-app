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
    let!(:old_registration) do
      create(:ten_year_old_registration, vessel_id: vessel.id)
    end

    let!(:latest_registration) do
      Registration.order("created_at desc").first
    end

    subject { vessel.current_registration }

    it { expect(subject).to eq(latest_registration) }
  end

  context "#historic_registrations builds unique registered_at dates" do
    let!(:ten_years_ago_1) do
      create(:ten_year_old_registration,
             registered_at: 10.years.ago, vessel_id: vessel.id)
    end

    let!(:ten_years_ago_2) do
      create(:nine_year_old_registration,
             registered_at: 10.years.ago, vessel_id: vessel.id)
    end

    let!(:latest_registration) do
      Registration.order("created_at desc").first
    end

    subject { vessel.historic_registrations }

    it do
      expect(subject).to eq([latest_registration, ten_years_ago_2])
    end
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
    let!(:vessel) { create(:unregistered_vessel) }
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

    context "with a closed registration" do
      before do
        create(
          :registration,
          vessel_id: vessel.id, closed_at: 1.day.ago)
      end

      it { expect(subject).to eq(:closed) }
    end

    context "with a frozen vessel" do
      before do
        vessel.update_attribute(:frozen_at, 1.day.ago)
      end

      it { expect(subject).to eq(:frozen) }
    end

    context "without a registration" do
      it { expect(subject).to eq(:pending) }
    end
  end

  context "#prints_registration_certificate?" do
    before do
      allow(vessel).to receive(:registration_status).and_return(status)
    end

    subject { vessel.prints_registration_certificate? }

    context "with status: registered" do
      let(:status) { :registered }

      it { expect(subject).to be_truthy }
    end

    context "with status: foo (i.e. any other status)" do
      let(:status) { :foo }

      it { expect(subject).to be_falsey }
    end
  end

  context "#prints_transcript?" do
    before do
      allow(vessel).to receive(:registration_status).and_return(status)
    end

    subject { vessel.prints_transcript? }

    context "with status: pending" do
      let(:status) { :pending }

      it { expect(subject).to be_falsey }
    end

    context "with status: foo (i.e. any other status)" do
      let(:status) { :foo }

      it { expect(subject).to be_truthy }
    end
  end

  context "#registry_info" do
    subject { vessel.registry_info }

    context "in general" do
      it "has the vessel attributes" do
        expect(subject[:vessel_info]["name"]).to eq(vessel.name)
      end

      it "has the owner attributes" do
        expect(subject[:owners][0]["name"]).to eq(vessel.owners.first.name)
      end

      it "has the agent attributes" do
        expect(subject[:agent]["name"]).to eq(vessel.agent.name)
      end
    end

    context "shareholder_groups" do
      before do
        group = vessel.shareholder_groups.create(shares_held: 10)
        group.shareholder_group_members.create(owner_id: vessel.owners.first.id)
      end

      it "has the shareholder_groups" do
        expect(subject[:shareholder_groups]).to eq(
          [{ group_members: [vessel.owners.first.email], shares_held: 10 }])
      end
    end
  end
end
