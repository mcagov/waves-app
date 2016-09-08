require "rails_helper"

RSpec.describe NotificationMailer, type: :mailer do
  describe "test_email" do
    let(:mail) { NotificationMailer.test_email("test@example.com") }

    it "renders the headers" do
      expect(mail.subject).to match(/Message from the MCA/)
      expect(mail.to).to eq(["test@example.com"])
      expect(mail.from).to eq([ENV.fetch("EMAIL_FROM")])
    end

    it "renders the body" do
      expect(mail.body.encoded).to match(/MCA test email/)
    end
  end

  describe "outstanding_declaration" do
    let(:mail) do
      NotificationMailer.outstanding_declaration(
        "test@example.com", "Alice", "foo")
    end

    let(:body) { mail.body.encoded }

    it "renders the headers" do
      expect(mail.subject)
        .to match(/Vessel Registration Owner Declaration Required/)
      expect(mail.to).to eq(["test@example.com"])
      expect(mail.from).to eq([ENV.fetch("EMAIL_FROM")])
    end

    it "renders the name" do
      expect(body).to match(/Dear Alice/)
    end

    it "renders the declaration_url" do
      expect(body).to include("/referral/outstanding_declaration/foo")
    end
  end

  describe "cancellation_owner_request" do
    it "renders the expected text"
  end

  describe "cancellation_no_response" do
    it "renders the expected text"
  end
end
