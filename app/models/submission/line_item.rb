class Submission::LineItem < ApplicationRecord
  self.table_name = "line_items"

  belongs_to :fee
  belongs_to :submission

  delegate :task_variant, to: :fee

  def subtotal
    (price.to_f + premium_addon_price.to_f) / 100
  end
end
