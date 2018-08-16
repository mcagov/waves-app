FactoryBot.define do
  factory :task, class: "Submission::Task" do
    submission    { build(:submission) }
    service       { build(:demo_service) }
    price         2500
    service_level :standard

    trait :premium do
      service_level :premium
    end
  end

  factory :unclaimed_task, parent: :task do
    after(:create) do |task|
      task.confirm!
    end
  end

  factory :claimed_task, parent: :unclaimed_task do
    after(:create) do |task|
      task.claim!(create(:user))
    end
  end

  factory :referred_task, parent: :claimed_task do
    after(:create) do |task|
      task.refer!
    end
  end

  factory :cancelled_task, parent: :claimed_task do
    after(:create) do |task|
      task.cancel!
    end
  end

  factory :completed_task, parent: :claimed_task do
    after(:create) do |task|
      task.complete!
    end
  end
end
