require "rails_helper"

describe Notification::Referral, type: :model do
  let(:notification) { described_class.new(notifiable: build(:submission)) }

  it "has the wysiwyg email_template" do
    expect(notification.email_template).to eq(:wysiwyg)
  end

  it "has the additional_params" do
    expect(notification.additional_params).to eq(notification.body)
  end

  it "has the email_subject" do
    expect(notification.email_subject)
      .to match("Application Referred - Action Required: Boaty McBoatface.*")
  end
end
