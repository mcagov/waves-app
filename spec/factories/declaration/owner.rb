FactoryGirl.define do
  factory :declaration_owner, class: "Declaration::Owner" do
    name        Faker::Name.name
    email       Faker::Internet.email
    address_1   "2 KEEN ROAD"
    town        "LONDON"
    country     "UNITED KINGDOM"
    postcode    "QZ2 3QM"
    nationality "UNITED KINGDOM"
  end
end
