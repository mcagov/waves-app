require "rails_helper"

describe Builders::OfficialNoBuilder do
  context ".build" do
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
end
