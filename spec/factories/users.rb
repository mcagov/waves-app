FactoryBot.define do
  factory :user do
    sequence(:email) { |n| "#{Faker::Internet.safe_email}-#{n}" }
    sequence(:name) { |n| "#{Faker::Name.name}-#{n}" }
    password "Password123!"
    access_level :operational_user
  end

  factory :system_manager, parent: :user do
    access_level :system_manager
  end

  factory :read_only_user, parent: :user do
    access_level :read_only
  end

  factory :operational_user, parent: :user do
    access_level :operational_user
  end
end
