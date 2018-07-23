FactoryGirl.define do
  factory :submission_task, class: "Submission::Task" do
    submission    { build(:submission) }
    service       { build(:demo_service) }
    service_level :standard
  end

  factory :unclaimed_submission_task, parent: :submission_task do
    after(:create) do |submission_task|
      submission_task.confirm!
    end
  end
end
