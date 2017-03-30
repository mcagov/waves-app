require "rails_helper"

describe Notification::RenewalReminder do
  let(:notification) { described_class.new(notifiable: build(:registration)) }

  it "is disabled" do
    expect { notification.send_email }
      .to raise_error(WavesError::BatchNotificationsAreDisabled)
  end
end
