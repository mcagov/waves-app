require "rails_helper"

describe Builders::OfficialNoBuilder do
  context ".build" do
    context "with a fishing vessel submission" do
      let(:submission) { create(:submission, part: :part_2) }

      context "a system-generated number" do
        before { described_class.build(submission) }

        it { expect(submission.vessel_reg_no).to be_present }
      end

      context "a user-input number" do
        before { described_class.build(submission, "VALID_NO") }

        it { expect(submission.vessel_reg_no).to eq("VALID_NO") }
      end
    end

    context "with a pleasure vessel submission" do
      let(:submission) { create(:submission, part: :part_1) }

      context "a system-generated number" do
        before { described_class.build(submission) }

        it { expect(submission.vessel_reg_no).to be_present }
      end
    end
  end

  context ".update" do
    let(:registered_vessel) { create(:registered_vessel) }

    before do
      described_class.update(registered_vessel, "FOOBAR")
    end

    it "updates the registered vessel reg_no" do
      expect(registered_vessel.reg_no).to eq("FOOBAR")
    end

    it "updates the registered vessel's current_registration" do
      expect(registered_vessel.current_registration.vessel.reg_no)
        .to eq("FOOBAR")
    end
  end
end
