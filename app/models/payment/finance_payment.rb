class Payment::FinancePayment < ApplicationRecord
  self.table_name = "finance_payments"

  has_one :payment, as: :remittance
  belongs_to :actioned_by, class_name: "User"

  validates :part, presence: true
  validates :payment_amount, presence: true, numericality: { only_integer: true }


  PAYMENT_TYPES = [
    ["Bacs", :bacs],
    ["Cash", :cash],
    ["Cheque", :cheque],
    ["Client Account", :client_account],
    ["Credit/Debit Card", :card],
    ["Postal Order", :postal_order],
  ].freeze

  def submission_ref_no
    payment.submission.ref_no
  end
end
