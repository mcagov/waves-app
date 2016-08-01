REGISTERS = ["Part 1", "Part 2", "Part 3", "Part 4"].freeze

VESSEL_TYPES = [
  "barge",
  "dinghy",
  "hovercraft",
  "inflatable",
  "motor sailer",
  "motor yacht",
  "narrow boat",
  "sailing yacht",
  "sports boat",
  "wet bike",
].freeze

USERS = ["develop"].freeze

REGISTERS.each { |register| Register.find_or_create_by(name: register) }

VESSEL_TYPES.each { |name| VesselType.find_or_create_by(name: name, key: name.parameterize) }

USERS.each do |user|
  u = User.find_or_initialize_by(name: user)
  u.email = "#{ user }@example.com"
  u.password = "password"
  u.save!
end

delivery_address = Address.create(
  address_1: Faker::Address.street_address,
  town: "Cardiff",
  postcode: Faker::Address.postcode,
  country: "GB"
  )

vessel_info = {
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

owner_1 = {
  name: Faker::Name.name,
  address_1: Faker::Address.street_address,
  address_2: Faker::Address.secondary_address,
  town: Faker::Address.city,
  county: "Cornwall",
  country: "GB"
}

owner_2 = {
  name: Faker::Name.name,
  address_1: Faker::Address.street_address,
  town: Faker::Address.city,
  country: "GB"
}

changeset = {
  vessel_info: vessel_info,
  owner_info_count: 2,
  owner_info_1: owner_1,
  owner_info_2: owner_2
}.to_json

Registration.create(
  ip_country:         "GB",
  card_country:       "GB",
  payment_id:         "PA12345",
  receipt_id:         "RE5678",
  status:             "paid",
  due_date:           20.days.from_now,
  is_urgent:          false,
  vessel_id:           nil,
  delivery_address:   delivery_address,
  changeset:          changeset
)
