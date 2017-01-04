class FinancePaymentBatch < ApplicationRecord
  belongs_to :started_by, class_name: "User"
  belongs_to :ended_by, class_name: "User"
end
