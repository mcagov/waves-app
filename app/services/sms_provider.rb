class SmsProvider
  class << self
    def send_otp(owners, otp)
      owners.each do |owner|
        # should be replaced with SMS service
        FakeSmsMailer.delay.send_otp(owner.email, otp)
      end
    end
  end
end
