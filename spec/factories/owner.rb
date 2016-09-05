FactoryGirl.define do
  factory :owner do
    name  Faker::Name.name
    email Faker::Internet.email
  end
end
