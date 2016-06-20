FactoryGirl.define do
  factory :address do
    sequence(:address_1) { |n| "#{n} Keen Road" }
    sequence(:town)      { |n| "Town #{n}" }
    sequence(:county)    { |n| "County #{n}" }
    postcode             { random_postcode }
    country              { ISO3166::Data.codes.sample }
  end
end
