require "rails_helper"

describe SmsProvider do
  context "#send_otp" do
    subject { SmsProvider.send_otp([], 123456) }

    it "sends a message" do
      expect(subject).to be_truthy
    end
  end
end
