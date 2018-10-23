FactoryBot.define do
  factory :mortgage do
    sequence(:priority_code) { "A" }
    mortgage_type            "Intent"
    mortgagees               { [build(:mortgagee)] }

    trait :registered do
      mortgage_type "Account Current"
      registered_at { 1.year.ago }
    end

    trait :discharged do
      mortgage_type "Account Current"
      discharged_at { 1.year.ago }
    end

    trait :intent do
      mortgage_type "Intent"
    end
  end
end
