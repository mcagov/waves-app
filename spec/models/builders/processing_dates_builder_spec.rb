require "rails_helper"

describe Builders::ProcessingDatesBuilder do
  describe ".create" do
    before do
      fee_schedule_instance =
        double(:fee_schedule_instance, service_level: service_level)

      expect(FeeSchedule)
        .to receive(:new).with(submission)
        .and_return(fee_schedule_instance)

      target_date_instance = double(:target_date_instance)

      expect(TargetDate)
        .to receive(:new).with(Date.today, service_level)
        .and_return(target_date_instance)

      expect(target_date_instance)
        .to receive(:calculate)
        .and_return(target_date)

      Builders::ProcessingDatesBuilder.create(submission)
    end

    let(:target_date) { Date.civil(2001, 11, 9) }
    let(:submission) { build(:submission) }

    context "with standard service" do
      let(:service_level) { :standard }

      it "does not set submission#is_urgent" do
        expect(submission.is_urgent).not_to be_truthy
      end

      it "sets submission#received_at" do
        expect(submission.received_at.to_date).to eq(Date.today)
      end

      it "ensures submission#referred_until is nil" do
        expect(submission.referred_until).to be_nil
      end

      it "sets submission#target_date" do
        expect(submission.target_date).to eq(target_date)
      end
    end

    context "with premium service" do
      let(:service_level) { :premium }

      it "sets submission#is_urgent flag" do
        expect(submission.is_urgent).to be_truthy
      end
    end
  end
end
