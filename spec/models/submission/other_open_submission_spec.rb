require "rails_helper"

describe Submission::OtherOpenSubmission do
  context ".for(submission" do
    let!(:registered_vessel) { create(:registered_vessel) }

    let!(:unassigned_submission) do
      create(:unassigned_submission, vessel_reg_no: registered_vessel.reg_no)
    end

    let!(:assigned_submission) do
      create(:assigned_submission, vessel_reg_no: registered_vessel.reg_no)
    end

    let!(:referred_submission) do
      create(:referred_submission, vessel_reg_no: registered_vessel.reg_no)
    end

    let!(:incomplete_submission) do
      create(:incomplete_submission, vessel_reg_no: registered_vessel.reg_no)
    end

    let!(:cancelled_submission) do
      create(:cancelled_submission, vessel_reg_no: registered_vessel.reg_no)
    end

    let!(:completed_submission) do
      create(:completed_submission, vessel_reg_no: registered_vessel.reg_no)
    end

    let!(:this_submission) do
      create(:submission, vessel_reg_no: registered_vessel.reg_no)
    end

    subject { described_class.for(this_submission) }

    it "returns the expected 'other open tasks'" do
      expect(subject).to eq(
        [
          unassigned_submission,
          assigned_submission,
          referred_submission,
        ])
    end
  end
end
