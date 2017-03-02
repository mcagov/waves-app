FactoryGirl.define do
  factory :submission_name_approval, class: "Submission::NameApproval" do
    name       Faker::Name
    submission { create(:submission) }
  end
end
