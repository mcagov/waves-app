FactoryBot.define do
  factory :mortgage do
    sequence(:priority_code) { "A" }
    mortgage_type            "Intent"
    mortgagees               { [build(:mortgagee)] }
  end
end
