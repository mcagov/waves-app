class LineItem < ApplicationRecord
  belongs_to :fee
  belongs_to :submission

  delegate :task_variant, to: :fee
end
