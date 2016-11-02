require "rails_helper"

describe Builders::ProcessingDatesBuilder do
  context ".create (invoked by: submission#init_processing_dates)" do
    let!(:calculated_date) { 1.year.ago }

    before do
      target_date = double(target_date)

      allow(TargetDate)
        .to receive(:new).with(Date.today, mode)
        .and_return(target_date)

      allow(target_date).to receive(:calculate).and_return(calculated_date)
    end

    context "with standard service" do
      let!(:submission) { create(:paid_submission) }
      let!(:mode) { :standard }

      it "sets the received_at date" do
        expect(submission.received_at).to be_present
      end

      it "sets the target_date" do
        expect(submission.target_date).to eq(calculated_date)
      end

      it "is not urgent" do
        expect(submission.is_urgent).to be_falsey
      end
    end

    context "with urgent service" do
      let!(:submission) { create(:paid_urgent_submission) }
      let(:mode) { :urgent }

      it "sets the target_date" do
        expect(submission.target_date).to eq(calculated_date)
      end

      it "sets the urgent flag" do
        expect(submission.is_urgent).to be_truthy
      end
    end
  end
end
