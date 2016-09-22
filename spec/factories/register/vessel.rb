FactoryGirl.define do
  factory :register_vessel, class: "Register::Vessel" do
    sequence(:name)           { |n| "Boaty McBoatface #{n}" }
    number_of_hulls           { rand(1..6) }
  end
end
