FactoryBot.define do
  factory :directed_by do
    name          Faker::Name.name
    email         Faker::Internet.email
    phone_number  Faker::PhoneNumber.phone_number
  end
end
