FactoryGirl.define do
  factory :registration do
    registered_at 1.day.ago
    task :vessel_details
  end
end
