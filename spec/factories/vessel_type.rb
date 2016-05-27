FactoryGirl.define do
  factory :vessel_type do
    sequence(:designation) { |n| "Vessel Type #{n}" }
  end
end
