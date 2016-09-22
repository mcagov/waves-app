FactoryGirl.define do
  factory :submission_vessel, class: "Submission::Vessel" do
    sequence(:name)           { |n| "Boaty McBoatface #{n}" }
    number_of_hulls           { rand(1..6) }
  end
end
