FactoryGirl.define do
  factory :registered_vessel, class: "Register::Vessel" do
    part                      :part_3
    sequence(:name)           { |n| "Boaty McBoatface #{n}" }
    number_of_hulls           { rand(1..6) }
    vessel_type               "BARGE"
    owners                    { [build(:register_owner)] }
  end

  after(:create) do
    build(:registration)
  end
end
