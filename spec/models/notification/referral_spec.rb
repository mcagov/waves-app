require "rails_helper"

describe Notification::Referral, type: :model do
  let(:referral) { described_class.new }

  it "has a due_by date" do
    expect(referral.due_by.to_date).to eq(30.days.from_now.to_date)
  end
end
