require "rails_helper"

describe Notification::Rejection, type: :model do
  context "in general" do
    it "has the rejection_unsuitable email_template" do
      notification = described_class.new(subject: :unsuitable_name)
      expect(notification.email_template).to eq(:rejection_unsuitable)
    end

    it "has the rejection_too_long email_template" do
      notification = described_class.new(subject: :too_long)
      expect(notification.email_template).to eq(:rejection_too_long)
    end

    it "has the rejection_fraudulent email_template" do
      notification = described_class.new(subject: :fraudulent)
      expect(notification.email_template).to eq(:rejection_fraudulent)
    end

    it "has the additional_params" do
      notification = described_class.new
      expect(notification.additional_params).to eq(notification.body)
    end
  end
end
