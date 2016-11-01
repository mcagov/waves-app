FactoryGirl.define do
  factory :registered_vessel, class: "Register::Vessel" do
    sequence(:name)           { |n| "Boaty McBoatface #{n}" }
    number_of_hulls           { rand(1..6) }
    vessel_type               "BARGE"
    owners                    { [build(:register_owner)] }
  end
end
