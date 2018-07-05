class Service < ApplicationRecord
  scope :part_1, -> { where.not(part_1: nil) }
  scope :part_2, -> { where.not(part_2: nil) }
  scope :part_3, -> { where.not(part_3: nil) }
  scope :part_4, -> { where.not(part_4: nil) }
end
