FactoryGirl.define do
  factory :payment do
    submission   { build(:submission) }
    amount       2500
    remittance   { build(:world_pay_payment) }
  end
end
