require "rails_helper"

describe Notification::Rejection, type: :model do
  let(:notification) { described_class.new(notifiable: build(:submission)) }

  it "has the wysiwyg email_template" do
    expect(notification.email_template).to eq(:wysiwyg)
  end

  it "has the additional_params" do
    expect(notification.additional_params)
      .to eq([notification.body, notification.actioned_by])
  end

  it "has the email_subject" do
    expect(notification.email_subject)
      .to match(/Application Rejected: Boaty McBoatface [0-9]/)
  end
end
