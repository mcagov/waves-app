FactoryGirl.define do
  factory :user do
    sequence(:email) { |n| "#{Faker::Internet.safe_email}-#{n}" }
    name Faker::Name.name
    password "password"
  end
end
