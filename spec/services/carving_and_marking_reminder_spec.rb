require "rails_helper"

describe CarvingAndMarkingReminder do
  before do
    create(:carving_and_marking, created_at: 4.months.ago).submission

    reminded =
      create(:carving_and_marking, created_at: 4.months.ago).submission
    reminded.update_attribute(:carving_and_marking_received_at, 1.day.ago)

    notified =
      create(:carving_and_marking, created_at: 4.months.ago).submission
    create(:carving_and_marking_reminder, notifiable: notified)
  end

  let!(:sent_notification_count) do
    Notification::CarvingAndMarkingReminder.count
  end

  it "runs once and sends one notification" do
    described_class.process

    expect(Notification::CarvingAndMarkingReminder.count)
      .to eq(sent_notification_count + 1)
  end

  it "runs twice but only sends one notification" do
    described_class.process
    described_class.process

    expect(Notification::CarvingAndMarkingReminder.count)
      .to eq(sent_notification_count + 1)
  end
end
