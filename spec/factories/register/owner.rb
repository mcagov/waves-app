FactoryBot.define do
  factory :registered_owner, class: "Register::Owner" do
    name          Faker::Name.name
    email         Faker::Internet.email
    phone_number  Faker::PhoneNumber.phone_number
  end
end
