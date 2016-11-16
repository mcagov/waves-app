require "rails_helper"

describe Notification, type: :model do
  describe "#create" do
    context "with valid params" do
      let!(:notification) { create(:notification) }

      it "is deliverable?" do
        expect(notification).to be_deliverable
      end

      it "delivers the email" do
        expect(Delayed::Job.count).to eq(1)
      end
    end

    context "with no recipient_email and recipient_name" do
      let!(:notification) do
        Notification.create(recipient_name: nil, recipient_email: nil)
      end

      it "is not deliverable?" do
        expect(notification).not_to be_deliverable
      end

      it "does not attempt to deliver the email" do
        expect(Delayed::Job.count).to eq(0)
      end
    end
  end
end
