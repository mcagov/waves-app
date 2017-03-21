FactoryGirl.define do
  factory :registration do
    registered_at 1.day.ago
    registered_until 5.years.from_now
    task :vessel_details
    registry_info { { owners: [build(:registered_owner)] } }
  end

  factory :ten_year_old_registration, class: "Registration" do
    created_at 10.years.ago
    task :vessel_details
  end

  factory :nine_year_old_registration, class: "Registration" do
    created_at 9.years.ago
    task :vessel_details
  end
end
