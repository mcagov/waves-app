class CarvingAndMarking < ApplicationRecord
  belongs_to :issued_by, class_name: "User"
  belongs_to :submission

  delegate :vessel_name, to: :submission
end
