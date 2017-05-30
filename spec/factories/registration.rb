FactoryGirl.define do
  factory :registration do
    registered_at 1.day.ago
    registered_until 5.years.from_now
    registry_info { { owners: [build(:registered_owner)] } }
  end

  factory :provisional_registration, parent: :registration do
    provisional :true
  end

  factory :ten_year_old_registration, class: "Registration" do
    created_at 10.years.ago
  end

  factory :nine_year_old_registration, class: "Registration" do
    created_at 9.years.ago
  end

  factory :renewable_registration, class: "Registration" do
    registered_until 90.days.from_now
  end

  factory :expirable_registration, class: "Registration" do
    renewal_reminder_at      90.days.ago
    registered_until         1.day.ago
  end

  factory :terminatable_registration, class: "Registration" do
    renewal_reminder_at      120.days.ago
    expiration_reminder_at   1.day.ago
    registered_until         31.days.ago
  end
end
