FactoryBot.define do
  factory :manager do
    name              Faker::Name.name
    email             Faker::Internet.email
    address_1     "2 KEEN ROAD"
    town          "LONDON"
    country       "UNITED KINGDOM"
    postcode      "QZ2 3QM"
    nationality   "BRITISH"
    safety_management { build(:safety_management) }
  end
end
