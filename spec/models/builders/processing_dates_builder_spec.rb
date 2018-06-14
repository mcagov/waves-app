require "rails_helper"

describe Builders::ProcessingDatesBuilder do
  describe ".create" do
    before do
      target_date_instance = double(:target_date_instance)

      expect(TargetDate)
        .to receive(:new).with(Time.zone.today, service_level.to_s)
        .and_return(target_date_instance)

      expect(target_date_instance)
        .to receive(:calculate)
        .and_return(target_date)

      Builders::ProcessingDatesBuilder.create(submission)
    end

    let(:submission) { build(:submission, service_level: service_level) }

    context "with standard service" do
      let(:service_level) { :standard }
      let(:target_date) { Date.civil(2001, 11, 9) }

      it "sets submission#received_at" do
        expect(submission.received_at.to_date).to eq(Time.zone.today)
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
      let(:target_date) { Date.civil(2001, 11, 9) }

      it "sets submission#target_date" do
        expect(submission.target_date).to eq(target_date)
      end
    end
  end
end
