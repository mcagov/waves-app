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

COUNTRIES = [
  ["GB", "United Kingdom"],
  ["FR", "France"],
  ["ES", "Spain"],
  ["PT", "Portugal"],
  ["VG", "British Virgin Islands"]
]

COUNTRIES.each { |country| Country.find_or_create_by(code: country.first, name: country.last) }

REGISTERS.each { |register| Register.find_or_create_by(name: register) }

VESSEL_TYPES.each { |name| VesselType.find_or_create_by(name: name, key: name.parameterize) }

USERS.each do |user|
  u = User.find_or_initialize_by(name: user)
  u.email = "#{ user }@example.com"
  u.password = "password"
  u.save!
end
