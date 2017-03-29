require "rails_helper"

describe Reminder do
  let!(:renewable_vessel) { create(:renewable_vessel) }

  context ".process_renewals" do
    subject { described_class.process_renewals }

    it "proceses renewals" do
      subject
      expect(Notification::RenewalReminder.all.map(&:notifiable)
        ).to eq([renewable_vessel])
    end
  end

  context ".process_expirations" do
    it "processes expirations"
  end

  context ".process_terminations" do
    it "processes terminations"
  end
end
