require "rails_helper"

describe SmsProvider do
  context "#send_access_code" do
    before do
      require "notifications/client"
      ENV["NOTIFY_API_KEY"] = "API_KEY_1"
      ENV["NOTIFY_TEMPLATE_ID"] = "TEMPLATE_ID_1"

      notify_client = double(notify_client)

      expect(Notifications::Client)
        .to receive(:new)
        .with("API_KEY_1")
        .and_return(notify_client)

      expect(notify_client)
        .to receive(:send_sms)
        .with(
          to: customer.phone_number,
          template: "TEMPLATE_ID_1",
          personalisation: { access_code: 12345 }
        )
    end

    let(:customer) { build(:customer, phone_number: "PHONE_1") }

    it "sends a message" do
      SmsProvider.send_access_code(customer, 12345)
    end
  end
end
