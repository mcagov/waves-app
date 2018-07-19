require "rails_helper"

describe Submission::Task do
  context "#ref_no" do
    let(:submission_task) { create(:submission_task) }
    subject { submission_task.ref_no }

    it { expect(subject).to eq("#{submission_task.submission.ref_no}/1") }
  end

  context "price is required" do
    let(:submission_task) { described_class.new(price: nil) }
    before { submission_task.valid? }

    it { expect(submission_task.errors).to include(:price) }
  end

  context "service_level is required" do
    let(:submission_task) { described_class.new(service_level: nil) }
    before { submission_task.valid? }

    it { expect(submission_task.errors).to include(:service_level) }
  end

  context "#start_date" do
    let(:submission) { create(:submission, received_at: "21/07/2016") }
    let(:submission_task) { create(:submission_task, submission: submission) }

    subject { submission_task.start_date }

    it "assigns the ref_no in the expected format" do
      expect(subject).to eq("21/07/2016".to_date)
    end
  end

  context "#confirm!" do
    let(:submission_task) do
      create(
        :submission_task,
        service_level: service_level,
        start_date: Date.current)
    end

    before do
      Timecop.travel(Time.new(2016, 6, 18))
      submission_task.confirm!
    end

    after do
      Timecop.return
    end

    context "target_date" do
      subject { submission_task.target_date }

      context "with standard service" do
        let(:service_level) { :standard }

        it "sets the target date to the service's standard_days" do
          expect(submission_task.target_date.to_date)
            .to eq(Date.civil(2016, 7, 1))
        end
      end

      context "with premium service" do
        let(:service_level) { :premium }

        it "sets the target date to the service's premium_days" do
          expect(submission_task.target_date.to_date)
            .to eq(Date.civil(2016, 6, 20))
        end
      end
    end
  end
end
