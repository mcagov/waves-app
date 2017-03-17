FactoryGirl.define do
  factory :charterer do
    charter_parties { [build(:charter_party)] }
  end
end
