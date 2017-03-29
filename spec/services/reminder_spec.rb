require "rails_helper"

describe Reminder do
  let!(:renewable_vessel) { create(:renewable_vessel) }
  let!(:expirable_vessel) { create(:expirable_vessel) }
  let!(:terminatable_vessel) { create(:terminatable_vessel) }

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
    before { described_class.process_terminations }

    it "proceses terminations" do
      expect(PrintJob.where(template: :termination).map(&:printable))
        .to eq([terminatable_vessel])
    end

    it "sets termination_at" do
      expect(terminatable_vessel.current_registration.termination_at)
        .to be_present
    end
  end
end
