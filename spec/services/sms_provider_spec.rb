require "rails_helper"

describe SmsProvider do
  context "#send_access_code" do
    subject { SmsProvider.send_access_code([], 123456) }

    it "sends a message" do
      expect(subject).to be_truthy
    end
  end
end
