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

REGISTERS.each { |register| Register.find_or_create_by(name: register) }

VESSEL_TYPES.each { |name| VesselType.find_or_create_by(name: name, key: name.parameterize) }
