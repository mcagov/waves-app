require "rails_helper"

describe Builders::OfficialNoBuilder do
  context ".build" do
    context "with a fishing vessel submission" do
      let(:submission) { create(:submission, part: :part_2) }

      context "a system-generated number" do
        before { described_class.build(submission) }

        it { expect(submission.vessel_reg_no).to be_present }

        it "builds the submission#vessel's ec_no" do
          reg_no = submission.vessel_reg_no
          expect(submission.vessel.ec_no).to eq("GBR000#{reg_no}")
        end
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

        it "does not build a submission#vessel's ec_no" do
          expect(submission.vessel.ec_no).to be_blank
        end
      end
    end
  end
end
