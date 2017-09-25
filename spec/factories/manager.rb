FactoryGirl.define do
  factory :manager do
    name              Faker::Name.name
    email             Faker::Internet.email
    safety_management { build(:safety_management) }
  end
end
