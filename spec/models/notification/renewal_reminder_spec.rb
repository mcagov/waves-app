require "rails_helper"

describe Notification::RenewalReminder do
  let(:notification) do
    described_class.create(notifiable: build(:registration))
  end

  it "is not deliverable" do
    expect(notification.deliverable?).to be_falsey
  end
end
