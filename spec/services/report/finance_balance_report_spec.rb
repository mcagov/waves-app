require "rails_helper"

describe Report::FinanceBalance do
  context "in general" do
    let!(:closed_submission) { create(:closed_submission) }

    before do
      submission = create(:submission, ref_no: "XXX")
      create(:completed_task, price: 1000, submission: submission)
      create(:payment, amount: 1000, submission: submission)

      submission = create(:submission, ref_no: "ABC")
      create(:completed_task, price: 900, submission: submission)
      create(:payment, amount: 1000, submission: submission)

      submission = create(:submission, ref_no: "DEF")
      create(:completed_task, price: 1000, submission: submission)
      create(:payment, amount: 900, submission: submission)
      submission
    end

    subject { described_class.new }

    it "has a title" do
      expect(subject.title).to eq("Finance Balance")
    end

    it "has 2 results" do
      expect(subject.results.count).to eq(2)
    end

    it do
      result = subject.results.map(&:data_elements).first
      expect(result[0]).to eq("ABC")
      expect(result[1].to_s).to eq("100")
      expect(result[2].to_s).to eq("0")
      expect(result[3]).to eq("Part 3")
    end

    it do
      result = subject.results.map(&:data_elements).last
      expect(result[0]).to eq("DEF")
      expect(result[1].to_s).to eq("0")
      expect(result[2].to_s).to eq("-100")
      expect(result[3]).to eq("Part 3")
    end
  end
end
