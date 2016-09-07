require "rails_helper"

RSpec.describe NotificationMailer, type: :mailer do
  describe "test_email" do
    let(:mail) { NotificationMailer.test_email }

    it "renders the headers" do
      expect(mail.subject).to match(/MCA test email/)
      expect(mail.to).to eq(["test@example.com"])
      expect(mail.from).to eq([ENV.fetch("EMAIL_FROM")])
    end

    it "renders the body" do
      expect(mail.body.encoded).to match(/MCA test email/)
    end
  end
end
