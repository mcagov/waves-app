FactoryGirl.define do
  factory :payment do
    submission { build(:submission) }
  end
end
