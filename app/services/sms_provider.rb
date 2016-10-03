class SmsProvider
  class << self
    def send_access_code(owners, access_code)
      owners.each do |owner|
        # should be replaced with SMS service
        FakeSmsMailer.delay.send_access_code(owner.email, access_code)
      end
    end
  end
end
