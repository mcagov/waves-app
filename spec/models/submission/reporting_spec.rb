require "rails_helper"

describe Submission::Reporting do
  describe "flag_in/out" do
    let!(:new_reg) { create(:submission, task: :new_registration) }
    let!(:closure) { create(:assigned_closure_submission) }

    context ".flag_in" do
      subject { Submission.flag_in }

      it "retrieves the new registration" do
        expect(subject).to eq([new_reg])
      end
    end

    context ".flag_out" do
      subject { Submission.flag_out }

      it "retrieves the closure" do
        expect(subject).to eq([closure])
      end
    end
  end

  xdescribe "merchant/fishing" do
    let!(:fishing) { create(:fishing_submission) }
    let!(:merchant) { create(:fishing_submission) }
  end

  describe "by register length" do
    let!(:under_15m) do
      create(:submission,
             changeset: { vessel_info: { register_length: 12.0 } })
    end

    let!(:between_15m_24m) do
      create(:submission,
             changeset: { vessel_info: { register_length: 16 } })
    end

    let!(:over_24m) do
      create(:submission,
             changeset: { vessel_info: { register_length: "44" } })
    end

    context ".under_15m" do
      it { expect(Submission.under_15m).to eq([under_15m]) }
    end

    context ".between_15m_24m" do
      it { expect(Submission.between_15m_24m).to eq([between_15m_24m]) }
    end

    context ".over_24m" do
      it { expect(Submission.over_24m).to eq([over_24m]) }
    end
  end
end
