require "rails_helper"

describe CodeCertificateReminder do
  before do
    @remindable = create(:registered_vessel, name: "REMINDABLE")
    create(:code_certificate,
           noteable: @remindable, expires_at: 59.days.from_now)

    not_due = create(:registered_vessel, name: "NOT DUE")
    create(:code_certificate,
           noteable: not_due, expires_at: 62.days.from_now)

    reminded = create(:registered_vessel, name: "REMINDED")
    create(:code_certificate,
           noteable: reminded, expires_at: 58.days.from_now)
    create(:code_certificate_reminder, notifiable: reminded)
  end

  let!(:sent_notification_count) do
    Notification::CodeCertificateReminder.count
  end

  context ".process" do
    before { described_class.process }

    it "creates one notification" do
      expect(Notification::CodeCertificateReminder.count)
        .to eq(sent_notification_count + 1)
    end

    it "sets the notification status to :pending_approval" do
      expect(Notification::CodeCertificateReminder.last.current_state)
        .to eq(:pending_approval)
    end

    it "sets the recipient to the vessel's correspondent" do
      notification = @remindable.code_certificate_reminder

      expect(notification.recipient_name).to eq(@remindable.correspondent.name)
      expect(notification.recipient_email)
        .to eq(@remindable.correspondent.email)
    end
  end

  it "runs twice but only sends one notification" do
    described_class.process
    described_class.process

    expect(Notification::CodeCertificateReminder.count)
      .to eq(sent_notification_count + 1)
  end
end
