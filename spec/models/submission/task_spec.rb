require "rails_helper"

describe Submission::Task do
  context "#ref_no" do
    let(:submission_task) { create(:submission_task) }
    subject { submission_task.ref_no }

    it { expect(subject).to eq("#{submission_task.submission.ref_no}/1") }
  end

  context "#start_date" do
    let(:submission) { create(:submission, received_at: "21/07/2016") }
    let(:submission_task) { create(:submission_task, submission: submission) }
    subject { submission_task.start_date }

    it { expect(subject).to eq("21/07/2016".to_date) }
  end

  context "#price" do
    let(:submission_task) do
      create(
        :submission_task,
        submission: create(:submission, part: :part_1),
        service: create(:demo_service),
        service_level: :standard)
    end
    subject { submission_task.price }

    it { expect(subject).to eq(12400) }
  end

  describe "model validations" do
    context "service_level is required" do
      let(:submission_task) { described_class.new(service_level: nil) }
      before { submission_task.valid? }

      it { expect(submission_task.errors).to include(:service_level) }
    end
  end

  describe "state machine events" do
    context "#confirm!" do
      let(:submission_task) { create(:submission_task) }

      before do
        expect(submission_task).to receive(:set_defaults)
      end

      it { submission_task.confirm! }
    end
  end

  context "#target_date" do
    let(:submission_task) { create(:submission_task) }
    subject { submission_task.target_date }

    it "is initialised as blank" do
      expect(subject).to be_blank
    end

    context "#confirm" do
      before do
        expect(TargetDate)
          .to receive(:for_task).with(submission_task).and_return("13/11/2012")

        submission_task.confirm!
      end

      it { expect(submission_task.target_date).to eq("13/11/2012".to_date) }
    end
  end
end
