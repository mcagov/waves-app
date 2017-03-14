FactoryGirl.define do
  factory :unregistered_vessel, class: "Register::Vessel" do
    part                      :part_3
    sequence(:name)           { |n| "Registered Boat #{n}" }
    number_of_hulls           { rand(1..6) }
    vessel_type               "BARGE"
    owners                    { [build(:registered_owner)] }
    agent                     { build(:registered_agent) }
    engines                   { [build(:engine)] }
    documents                 { [build(:document)] }
    mortgages                 { [build(:mortgage)] }
    beneficial_owners         { [build(:beneficial_owner)] }
    directed_bys              { [build(:directed_by)] }
    representative            { build(:registered_representative) }
    propulsion_system         { [:outboard_diesel, :steam] }
    registration_type         "full"
  end

  factory :registered_vessel, parent: :unregistered_vessel do
    after(:create) do |vessel|
      create(:registration,
             registered_vessel: vessel,
             registry_info: vessel.registry_info,
             registered_at: 1.year.ago)
    end
  end

  factory :fishing_vessel, parent: :registered_vessel do
    part :part_2
  end

  factory :pleasure_vessel, parent: :registered_vessel do
    part :part_1
  end
end
