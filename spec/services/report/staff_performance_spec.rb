require "rails_helper"

describe Report::StaffPerformance do
  context "in general" do
    subject { described_class.new }

    it "has a title" do
      expect(subject.title).to eq("Staff Performance")
    end

    it "has some columns" do
      columns = [:task_type, :total_transactions, :top_performer]
      expect(subject.columns).to eq(columns)
    end

    it "has one row for each task type" do
      expect(subject.rows.length).to eq(Task.all_task_types.length)
    end
  end
end
