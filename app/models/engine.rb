class Engine < ApplicationRecord
  belongs_to :parent, polymorphic: true

  ENGINE_TYPES = %w(Inboard Outboard).freeze

  DERATINGS = [
    "None",
    "Fuel Rack Limited",
    "Fuel Pump Changed",
    "Engine Governor Adjusted",
    "Turbo Charger Removed",
    "Electronic Governor Modified",
    "Other agreed method",
  ].freeze

  def make_and_model
    [make, model].join(" ")
  end
end
