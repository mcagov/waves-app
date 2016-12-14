FactoryGirl.define do
  factory :submission_vessel, class: "Submission::Vessel" do
    sequence(:name)           { |n| "Boaty McBoatface #{n}" }
    number_of_hulls           5
    vessel_type               "BARGE"
    alt_name_1                "ALT NAME 1"
    alt_name_2                "ALT NAME 2"
    alt_name_3                "ALT NAME 3"
  end
end
