class Payment::WorldPay < ApplicationRecord
  self.table_name = "world_pay_payments"
  has_one :payment, as: :remittance
end
