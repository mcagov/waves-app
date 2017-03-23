FactoryGirl.define do
  factory :registration do
    registered_at 1.day.ago
    registered_until 5.years.from_now
    registry_info { { owners: [build(:registered_owner)] } }
  end

  factory :ten_year_old_registration, class: "Registration" do
    created_at 10.years.ago
  end

  factory :nine_year_old_registration, class: "Registration" do
    created_at 9.years.ago
  end
end
