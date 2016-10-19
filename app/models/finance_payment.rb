class FinancePayment < ApplicationRecord
  belongs_to :actioned_by, class_name: "User"
end
