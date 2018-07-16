FactoryGirl.define do
  factory :submission_task, class: "Submission::Task" do
    submission    { build(:unassigned_submission) }
    service       { build(:demo_service) }
    service_level :standard
  end
end
