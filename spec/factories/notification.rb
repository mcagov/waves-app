FactoryGirl.define do
  factory :notification do
    recipient_name  Faker::Name.name
    recipient_email Faker::Internet.email
  end
end