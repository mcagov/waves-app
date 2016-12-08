FactoryGirl.define do
  factory :registered_agent, class: "Register::Agent" do
    name          Faker::Name.name
    email         Faker::Internet.email
    phone_number  Faker::PhoneNumber.phone_number
  end
end
