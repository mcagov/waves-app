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

USERS = %w(alice bob charlie develop).freeze

# rubocop:disable WordArray
COUNTRIES = [
  ["GB", "United Kingdom"],
  ["FR", "France"],
  ["ES", "Spain"],
  ["PT", "Portugal"],
  ["VG", "British Virgin Islands"],
].freeze

COUNTRIES.each do |country|
  Country.find_or_create_by(code: country.first, name: country.last)
end

VESSEL_TYPES.each do |name|
  VesselType.find_or_create_by(name: name, key: name.parameterize)
end

USERS.each do |user|
  u = User.find_or_initialize_by(name: user.humanize)
  u.email = "#{user}@example.com"
  u.password = "password"
  u.save!
end
