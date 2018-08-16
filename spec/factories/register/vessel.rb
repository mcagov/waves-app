FactoryBot.define do
  factory :unregistered_vessel, class: "Register::Vessel" do
    part                      :part_3
    sequence(:name)           { |n| "Registered Boat #{n}" }
    number_of_hulls           { rand(1..6) }
    vessel_type               "BARGE"
    owners                    { [build(:registered_owner)] }
    agent                     { build(:registered_agent) }
    engines                   { [build(:engine)] }
    documents                 { [build(:document)] }
    managers                  { [build(:manager)] }
    csr_forms                 { [build(:csr_form)] }
    mortgages                 { [build(:mortgage)] }
    charterers                { [build(:charterer)] }
    beneficial_owners         { [build(:beneficial_owner)] }
    directed_bys              { [build(:directed_by)] }
    managed_bys               { [build(:managed_by)] }
    representative            { build(:registered_representative) }
    propulsion_system         { "Fins" }
    registration_type         "full"
    gross_tonnage             500
  end

  factory :registered_vessel, parent: :unregistered_vessel do
    after(:create) do |vessel|
      registration =
        create(:registration,
               registered_vessel: vessel,
               registry_info: vessel.registry_info,
               registered_at: 1.year.ago)
      vessel.update_attributes(current_registration: registration)
    end
  end

  factory :provisionally_registered_vessel, parent: :registered_vessel do
    after(:create) do |vessel|
      provisional_registration =
        create(:provisional_registration,
               registered_vessel: vessel)
      vessel.update_attributes(current_registration: provisional_registration)
    end
  end

  factory :pending_vessel, class: "Register::Vessel" do
    part              :part_3
    sequence(:name)   { |n| "Registered Boat #{n}" }
  end

  factory :fishing_vessel, parent: :registered_vessel do
    part :part_2
  end

  factory :part_4_fishing_vessel, parent: :registered_vessel do
    part :part_4
    registration_type "fishing"
  end

  factory :part_4_vessel, parent: :registered_vessel do
    part :part_4
  end

  factory :pleasure_vessel, parent: :registered_vessel do
    part :part_1
    registration_type "pleasure"
  end

  factory :merchant_vessel, parent: :registered_vessel do
    part :part_1
    registration_type "commercial"
  end

  factory :renewable_vessel, parent: :unregistered_vessel do
    after(:create) do |vessel|
      create(:renewable_registration, registered_vessel: vessel)
    end
  end

  factory :expirable_vessel, parent: :unregistered_vessel do
    after(:create) do |vessel|
      create(:expirable_registration, registered_vessel: vessel)
    end
  end

  factory :terminatable_vessel, parent: :unregistered_vessel do
    after(:create) do |vessel|
      create(:terminatable_registration, registered_vessel: vessel)
    end
  end
end
