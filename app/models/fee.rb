class Fee < ApplicationRecord
  class << self
    def for(fee_category)
      Fee.where(category: [fee_category, :all_parts]).order(:task_variant)
    end
  end
end
