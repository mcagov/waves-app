class Submission::LineItem < ApplicationRecord
  self.table_name = "line_items"

  belongs_to :fee
  belongs_to :submission

  delegate :task_variant, to: :fee

  def subtotal
    (price.to_f + premium_addon_price.to_f) / 100
  end

  def price_in_pounds
    (price.to_f / 100.0)
  end

  def price_in_pounds=(val)
    self.price = (val.to_f * 100).to_i
  end
end
