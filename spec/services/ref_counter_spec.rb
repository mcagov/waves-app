require "rails_helper"

describe RefCounter do
  context "incrementing" do
    let!(:submission) { create(:submission) }

    let!(:submission_task_1) do
      create(:submission_task, submission: submission)
    end

    let!(:submission_task_2) do
      create(:submission_task, submission: submission)
    end

    context "the first" do
      it { expect(RefCounter.next(submission_task_1)).to eq(1) }
    end

    context "the second" do
      before { submission_task_1.update_attribute(:submission_ref_counter, 1) }

      it { expect(RefCounter.next(submission_task_2)).to eq(2) }
    end
  end
end
