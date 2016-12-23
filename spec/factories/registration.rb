FactoryGirl.define do
  factory :registration do
    registered_at 1.day.ago
    task :vessel_details
  end

  factory :ten_year_old_registration, class: "Registration" do
    created_at 10.years.ago
    task :vessel_details
  end
end
