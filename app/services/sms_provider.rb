class SmsProvider
  class << self
    def send_access_code(customer, access_code)
      require "notifications/client"
      begin
        client = Notifications::Client.new(ENV["NOTIFY_API_KEY"])
        client.send_sms(to: customer.phone_number,
                        template: ENV["NOTIFY_TEMPLATE_ID"],
                        personalisation: { access_code: access_code })

      rescue Notifications::Client::RequestError
        raise WavesError::SmsProviderError
      end
    end
  end
end
