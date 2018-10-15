FactoryBot.define do
  factory :registered_agent, class: "Register::Agent" do
    name          Faker::Name.name
    address_1     "2 KEEN ROAD"
    town          "LONDON"
    country       "UNITED KINGDOM"
    postcode      "QZ2 3QM"
    nationality   "BRITISH"
    email         Faker::Internet.email
    phone_number  Faker::PhoneNumber.phone_number
  end
end
