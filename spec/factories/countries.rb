FactoryGirl.define do
  factory :country do
    name { Faker::Address.country }
    code { Faker::Address.country_code }
  end
end
