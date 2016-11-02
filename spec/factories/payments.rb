FactoryGirl.define do
  factory :payment do
    submission   { build(:submission) }
    amount       2500
  end
end
