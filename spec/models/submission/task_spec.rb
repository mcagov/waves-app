require "rails_helper"

describe Submission::Task do
  context "#ref_no" do
    let(:submission_task) { create(:submission_task) }
    subject { submission_task.ref_no }

    it "assigns the ref_no in the expected format" do
      expect(subject).to eq("#{submission_task.submission.ref_no}/1")
    end
  end
end
