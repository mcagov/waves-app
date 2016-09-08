require "rails_helper"

describe Notification::Referral, type: :model do
  let(:referral) { described_class.new }

  it "has a due_by date" do
    expect(referral.due_by.to_date).to eq(30.days.from_now.to_date)
  end

  it "has the referral_unknown email_template" do
    referral.subject = :unknown_vessel_type
    expect(referral.email_template).to eq(:referral_unknown)
  end

  it "has the referral_no_match email_template" do
    referral.subject = :length_and_vessel_type_do_not_match
    expect(referral.email_template).to eq(:referral_no_match)
  end

  it "has the referral_incorrect email_template" do
    referral.subject = :hull_identification_number_appears_incorrect
    expect(referral.email_template).to eq(:referral_incorrect)
  end

  it "has the additional_params" do
    expect(referral.additional_params).to eq(referral.body)
  end
end
