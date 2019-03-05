require "rails_helper"

describe Report::FinanceBalance do
  context "in general" do
    let!(:closed_submission) { create(:closed_submission) }

    let!(:submission_with_neutral_balance) do
      submission = create(:submission)
      create(:completed_task, price: 1000, submission: submission)
      create(:payment, amount: 1000, submission: submission)
      submission
    end

    let!(:submission_with_incomplete_balance) do
      submission = create(:submission, created_at: 1.week.ago, part: :part_2)
      create(:completed_task, price: 900, submission: submission)
      create(:payment, amount: 1000, submission: submission)
      submission
    end

    let!(:submission_with_underpayment) do
      submission = create(:submission, created_at: 1.day.ago)
      create(:completed_task, price: 1000, submission: submission)
      create(:payment, amount: 900, submission: submission)
      submission
    end

    subject { described_class.new }

    it "has a title" do
      expect(subject.title).to eq("Finance Balance (Incomplete/Underpayment)")
    end

    it do
      result = subject.results.map(&:data_elements).first
      expect(result[0]).to eq(submission_with_incomplete_balance.ref_no)
      expect(result[1].to_s).to eq("100")
      expect(result[2].to_s).to eq("0")
      expect(result[3]).to eq("Part 2")
    end

    it do
      result = subject.results.map(&:data_elements).last
      expect(result[0]).to eq(submission_with_underpayment.ref_no)
      expect(result[1].to_s).to eq("0")
      expect(result[2].to_s).to eq("-100")
      expect(result[3]).to eq("Part 3")
    end
  end
end
