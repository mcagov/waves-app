require "rails_helper"

describe Notification, type: :model do
  describe "#create" do
    let!(:notification) { build(:notification) }
    let!(:delayed_job_count) { Delayed::Job.count }

    before do
      allow(notification)
        .to receive(:deliverable?)
        .and_return(deliverable?)

      notification.save!
    end

    context "when it is deliverable" do
      let(:deliverable?) { true }

      it "delivers the email" do
        expect(Delayed::Job.count).to eq(delayed_job_count + 1)
      end

      it "sets the delivered_at" do
        expect(notification.delivered_at).to be_present
      end

      it "sets the state" do
        expect(notification.current_state).to eq(:delivered)
      end
    end

    context "when it is not deliverable" do
      let(:deliverable?) { false }

      it "does not delivers the email" do
        expect(Delayed::Job.count).to eq(delayed_job_count)
      end

      it "does not set the delivered_at" do
        expect(notification.delivered_at).to be_nil
      end

      it "retains the initial state" do
        expect(notification.current_state).to eq(:ready_for_delivery)
      end
    end
  end

  context "#deliverable?" do
    let(:notification) { build(:notification) }

    subject { notification.deliverable? }

    it "with valid params" do
      expect(subject).to be_truthy
    end

    it "has no recipient_name" do
      notification.recipient_name = nil
      expect(subject).to be_falsey
    end

    it "has no recipient_name" do
      notification.recipient_email = nil
      expect(subject).to be_falsey
    end
  end
end
