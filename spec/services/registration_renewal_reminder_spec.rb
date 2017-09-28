require "rails_helper"

describe RegistrationRenewalReminder do
  before do
    @remindable = create(:registered_vessel, name: "REMINDABLE")
    @remindable.current_registration.update_attributes(
      registered_until: 89.days.from_now)

    not_due = create(:registered_vessel, name: "NOT DUE")
    not_due.current_registration.update_attributes(
      registered_until: 91.days.from_now)

    reminded = create(:registered_vessel, name: "REMINDED")
    reminded.current_registration.update_attributes(
      registered_until: 88.days.from_now,
      renewal_reminder_at: 1.day.ago)
  end

  let!(:sent_notification_count) do
    Notification::RenewalReminder.count
  end

  context ".process" do
    before { described_class.process }

    it "sends one email" do
      expect(Notification::RenewalReminder.count)
        .to eq(sent_notification_count + 1)
    end

    it "sets the recipient to the vessel's correspondent" do
      notification = @remindable.renewal_reminder

      expect(notification.recipient_name).to eq(@remindable.correspondent.name)
      expect(notification.recipient_email)
        .to eq(@remindable.correspondent.email)
    end

    it "sets the attachment" do
      notification = @remindable.renewal_reminder

      expect(notification.attachments.to_sym).to eq(:renewal_reminder_letter)
    end
  end

  it "runs twice but only sends one notification" do
    described_class.process
    described_class.process

    expect(Notification::RenewalReminder.count)
      .to eq(sent_notification_count + 1)
  end
end
