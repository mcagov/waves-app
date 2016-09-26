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

  context "#submission_list" do
    before do
      create(:registration, vessel: vessel, submission: new_registration)
    end

    let(:new_registration) { create(:new_registration) }

    subject { vessel.submission_list }

    it { expect(subject).to include(new_registration) }

    it "will eventually include *other* submissions, e.g. change of owner"
  end

  context "#notification_list" do
    let!(:vessel_correspondence) do
      create(:correspondence, noteable: vessel)
    end

    let!(:submission) { create(:submission) }
    let!(:submission_correspondence) do
      create(:correspondence, noteable: submission)
    end

    before do
      allow(vessel)
        .to receive(:submission_list).and_return([submission])
    end

    subject { vessel.notification_list }

    it "returns the expected notification_list" do
      expect(subject)
        .to eq([submission_correspondence, vessel_correspondence])
    end
  end
end
