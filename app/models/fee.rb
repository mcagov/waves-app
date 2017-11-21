class Fee < ApplicationRecord
  class << self
    def for(fee_category)
      Fee.where(category: [fee_category, :all_parts]).order(:task_variant)
    end
  end

  scope :transfers_in, -> { where(task_variant: :transfer_from_bdt) }
  scope :transfers_out, -> { where(task_variant: :transfer_to_bdt) }
end
