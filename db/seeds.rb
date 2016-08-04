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

new_registration_json = JSON.parse(File.read('spec/fixtures/new_registration.json'))
Registration.create(new_registration_json["data"]["attributes"])
