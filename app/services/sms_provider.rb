class SmsProvider
  class << self
    def send_access_code(customer, access_code)
      # should be replaced with SMS service
      FakeSmsMailer.delay.send_access_code(customer.email, access_code)
    end
  end
end
