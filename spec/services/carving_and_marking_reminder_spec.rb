require "rails_helper"

describe CarvingAndMarkingReminder do
  before do
    @remindable =
      create(:carving_and_marking, created_at: 4.months.ago).submission
    @remindable.update_attributes(
      applicant_name: "BOB", applicant_email: "bob@example.com")

    received =
      create(:carving_and_marking, created_at: 4.months.ago).submission
    received.update_attribute(:carving_and_marking_received_at, 1.day.ago)

    notified =
      create(:carving_and_marking, created_at: 4.months.ago).submission
    create(:carving_and_marking_reminder, notifiable: notified)
  end

  let!(:sent_notification_count) do
    Notification::CarvingAndMarkingReminder.count
  end

  context ".process" do
    before { described_class.process }

    it "sends one email" do
      expect(Notification::CarvingAndMarkingReminder.count)
        .to eq(sent_notification_count + 1)
    end

    it "sets the recipient" do
      notification = @remindable.carving_and_marking_reminder

      expect(notification.recipient_name).to eq("BOB")
      expect(notification.recipient_email).to eq("bob@example.com")
    end
  end

  it "runs twice but only sends one notification" do
    described_class.process
    described_class.process

    expect(Notification::CarvingAndMarkingReminder.count)
      .to eq(sent_notification_count + 1)
  end
end
