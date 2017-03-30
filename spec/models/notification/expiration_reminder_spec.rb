require "rails_helper"

describe Notification::RenewalReminder do
  let(:notification) { described_class.new(notifiable: build(:registration)) }

  it "is not deliverable" do
    expect(notification.deliverable?).to be_falsey
  end
end
