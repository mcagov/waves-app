require "rails_helper"

describe TerminatedVessels do
  context "close!" do
    let!(:vessel_1) { create(:registered_vessel) }
    let!(:vessel_2) { create(:registered_vessel) }
    let!(:vessel_3) { create(:registered_vessel) }

    before do
      init_closeable_vessel(vessel_2)
      init_non_closeable_vessel(vessel_3)

      described_class.close!
    end

    it "leaves vessel_1 as registered" do
      expect(vessel_1.reload.registration_status).to eq(:registered)
    end

    it "closes the registration for vessel_2" do
      vessel = vessel_2.reload
      expect(vessel.registration_status).to eq(:closed)
      expect(vessel.current_state).to eq(:active)
    end

    it "skips vessel_3" do
      vessel = vessel_3.reload
      expect(vessel.registration_status).to eq(:registered)
      expect(vessel.current_state).to eq(:termination_notice_issued)
    end
  end
end

def init_closeable_vessel(vessel)
  section_notice = Register::SectionNotice.create(noteable: vessel)
  vessel.issue_section_notice!
  vessel.issue_termination_notice!
  vessel.update_column(:termination_notice_issued_at, 8.days.ago)
  section_notice.update_column(:updated_at, 8.days.ago)
end

def init_non_closeable_vessel(vessel)
  section_notice = Register::SectionNotice.create(noteable: vessel)
  vessel.issue_section_notice!
  vessel.issue_termination_notice!
  vessel.update_column(:termination_notice_issued_at, 6.days.ago)
  section_notice.update_column(:updated_at, 6.days.ago)
end
