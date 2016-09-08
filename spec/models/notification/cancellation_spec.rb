require "rails_helper"

describe Notification::Cancellation, type: :model do
  context "in general" do
    it "has the owner_request email_template" do
      notification = described_class.new(subject: :owner_request)
      expect(notification.email_template).to eq(:cancellation_owner_request)
    end

    it "has the no_reponse_from_owner email_template" do
      notification = described_class.new(subject: :no_reponse_from_owner)
      expect(notification.email_template).to eq(:cancellation_no_response)
    end

    it "has the additional_params" do
      notification = described_class.new
      expect(notification.additional_params).to eq(notification.body)
    end
  end
end
