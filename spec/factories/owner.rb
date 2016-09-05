FactoryGirl.define do
  factory :declaration_owner, class: "Declaration::Owner" do
    name  Faker::Name.name
    email Faker::Internet.email
  end
end
