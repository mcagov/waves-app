FactoryGirl.define do
  factory :registration do
    ip_country        "GB"
    card_country      "GB"
    payment_id        "PA12345"
    receipt_id        "RE5678"
    status            "paid"
    due_date          {20.days.from_now}
    is_urgent         false
    changeset         changeset
  end

  trait :changeset do
    {
      vessel_info: vessel_info,
      owner_info_count: 2,
      owner_info_1: owner_1,
      owner_info_2: owner_2
    }
  end

  trait :vessel_info do
    {
      name: "MV Karin",
      hin: "GB-111111111111",
      make_and_model: "Mirror Dinghy",
      length_in_centimeters: 1200,
      number_of_hulls: "1",
      vessel_type: "dinghy",
      vessel_type_other:"",
      mmsi_number: "234422993",
      radio_call_sign: "111111"
    }
  end

  trait :owner_1 do
    {
      name: Faker::Name.name,
      address_1: Faker::Address.street_address,
      address_2: Faker::Address.secondary_address,
      town: Faker::Address.city,
      county: "Cornwall",
      country: "GB"
    }
  end

  trait :owner_2 do
    {
      name: Faker::Name.name,
      address_1: Faker::Address.street_address,
      town: Faker::Address.city,
      country: "GB"
    }
  end
end
