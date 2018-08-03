FactoryBot.define do
  factory :notification do
    recipient_name  Faker::Name.name
    recipient_email Faker::Internet.email
    notifiable      { build(:submission) }
  end
end
