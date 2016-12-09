FactoryGirl.define do
  factory :unregistered_vessel, class: "Register::Vessel" do
    part                      :part_3
    sequence(:name)           { |n| "Boaty McBoatface #{n}" }
    number_of_hulls           { rand(1..6) }
    vessel_type               "BARGE"
    owners                    { [build(:registered_owner)] }
    agent                     { build(:registered_agent) }
  end

  factory :registered_vessel, parent: :unregistered_vessel do
    after(:create) do |vessel|
      create(:registration,
             registered_vessel: vessel,
             registry_info: vessel.registry_info,
             registered_at: 1.year.ago)
    end
  end
end
