require "rails_helper"

describe Reminder do
  let!(:renewable_vessel) { create(:renewable_vessel) }
  let!(:expirable_vessel) { create(:expirable_vessel) }

  context ".process_renewals" do
    before { described_class.process_renewals }

    it "proceses renewals" do
      expect(Notification::RenewalReminder.all.map(&:notifiable))
        .to eq([renewable_vessel])
    end

    it "sets renewal_reminder_at" do
      expect(renewable_vessel.current_registration.renewal_reminder_at)
        .to be_present
    end
  end

  context ".process_expirations" do
    before { described_class.process_expirations }

    it "proceses expirations" do
      expect(Notification::ExpirationReminder.all.map(&:notifiable))
        .to eq([expirable_vessel])
    end

    it "sets expiration_reminder_at" do
      expect(expirable_vessel.current_registration.expiration_reminder_at)
        .to be_present
    end
  end

  context ".process_terminations" do
    it "processes terminations"
  end
end
