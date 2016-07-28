FactoryGirl.define do
  factory :vessel_type do
    sequence(:name) { |n| "Vessel Type #{n}" }
    sequence(:key) { |n| "vessel-type-#{n}" }
  end
end
