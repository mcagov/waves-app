REGISTERS = ["Part 1", "Part 2", "Part 3", "Part 4"].freeze
VESSEL_TYPES = [
  "barge",
  "dinghy",
  "hovercraft",
  "inflatable",
  "motor sailer",
  "motor yacht",
  "narrow boat",
  "other",
  "sailing yacht",
  "sports boat",
  "wet bike",
].freeze

REGISTERS.each { |register| Register.find_or_create_by(name: register) }

VESSEL_TYPES.each { |type| VesselType.find_or_create_by(designation: type) }
