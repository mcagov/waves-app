require "rails_helper"

describe Report::StaffPerformance do
  context "in general" do
    let(:service) { create(:service, name: "New Reg") }

    before do
      create(:staff_performance_log,
             task: create(:task, service: service),
             target_date: 1.day.from_now)

      create(:staff_performance_log,
             task: create(:task, service: service),
             target_date: 1.day.ago)
    end

    subject { described_class.new }

    it "has a title" do
      expect(subject.title).to eq("Staff Performance")
    end

    it "has some filter_fields" do
      expect(subject.filter_fields).to eq([:filter_part, :filter_date_range])
    end

    it "has some headings" do
      headings =
        [
          :task_type, :total_transactions,
          :within_service_standard, :service_standard_missed
        ]
      expect(subject.headings).to eq(headings)
    end

    it "has a date range label" do
      expect(subject.date_range_label).to eq("Application Received")
    end

    it "has one result for each task type" do
      expect(subject.results.length).to eq(1)
    end

    it "has the expected output" do
      results = subject.results.map(&:data_elements).first
      expect(results[0]).to eq("New Reg")
      expect(results[1]).to eq(2)
      expect(results[2]).to eq(1)
      expect(results[3]).to be_a(Report::RenderAsRed)
    end

    it "has the application_type as a sub_report_filter" do
      new_reg = { service: service.id }
      expect(subject.results.map(&:sub_report_filters)).to include(new_reg)
    end
  end
end
