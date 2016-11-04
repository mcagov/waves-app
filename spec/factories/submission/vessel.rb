FactoryGirl.define do
  factory :submission_vessel, class: "Submission::Vessel" do
    sequence(:name)           { |n| "Boaty McBoatface #{n}" }
    number_of_hulls           5
    vessel_type               "BARGE"
  end
end
