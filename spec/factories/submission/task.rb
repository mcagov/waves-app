FactoryGirl.define do
  factory :submission_task, class: "Submission::Task" do
    submission    { build(:submission) }
    service       { build(:demo_service) }
    price         2500
    service_level :standard

    trait :premium do
      service_level :premium
    end
  end

  factory :unclaimed_submission_task, parent: :submission_task do
    after(:create) do |submission_task|
      submission_task.confirm!
    end
  end

  factory :claimed_submission_task, parent: :unclaimed_submission_task do
    after(:create) do |submission_task|
      submission_task.claim!(create(:user))
    end
  end

  factory :referred_submission_task, parent: :claimed_submission_task do
    after(:create) do |submission_task|
      submission_task.refer!
    end
  end

  factory :cancelled_submission_task, parent: :claimed_submission_task do
    after(:create) do |submission_task|
      submission_task.cancel!
    end
  end

  factory :completed_submission_task, parent: :claimed_submission_task do
    after(:create) do |submission_task|
      submission_task.complete!
    end
  end
end
