class Submission::LineItem < ApplicationRecord
  self.table_name = "line_items"

  belongs_to :fee
  belongs_to :submission

  delegate :task_variant, to: :fee
end
