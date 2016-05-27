FactoryGirl.define do
  factory :vessel do
    sequence(:name)           { |n| "Boaty McBoatface #{n}" }
    hin                       { "UK-#{rand.to_s[2..13]}" }
    sequence(:make_and_model) { |n| "Makey McMakeface #{n}" }
    length_in_centimeters     { rand(1..2399) }
    number_of_hulls           { rand(1..6) }
    vessel_type               { create(:vessel_type) }
    mmsi_number               { "#{rand(232..235)}#{rand.to_s[2..7]}" }
    radio_call_sign           { "#{(65 + rand(25)).chr}#{rand.to_s[2..6]}" }
  end
end
