FactoryGirl.define do
  factory :register_vessel, class: "Register::Vessel" do
    sequence(:name)           { |n| "Boaty McBoatface #{n}" }
    hin                       { random_hin }
    sequence(:make_and_model) { |n| "Makey McMakeface #{n}" }
    length_in_meters          { rand(1..2399) }
    number_of_hulls           { rand(1..6) }
    vessel_type               "Boat"
    mmsi_number               { random_mmsi_number }
    radio_call_sign           { random_radio_call_sign }
  end
end
