require "rails_helper"

describe Report::StaffPerformance do
  context "in general" do
    before do
      create(:completed_submission)
    end

    let(:filters) { { part: :part_3 } }

    subject { described_class.new(filters) }

    it "has a title" do
      expect(subject.title).to eq("Staff Performance")
    end

    it "has some columns" do
      columns = [:task_type, :total_transactions, :top_performer]
      expect(subject.columns).to eq(columns)
    end

    it "has one result for each task type" do
      expect(subject.results.length).to eq(Task.all_task_types.length)
    end

    it "has the expected output for a new registration" do
      new_reg = ["New Registration", 1, "#{Submission.last.claimant} (1)"]
      expect(subject.results.map(&:data_elements)).to include(new_reg)
    end

    it "has the tasktype as subreport" do
      expect(subject.results.map(&:subreport)).to include(:new_registration)
    end
  end
end
