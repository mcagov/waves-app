class Payment::FinancePayment < ApplicationRecord
  self.table_name = "finance_payments"

  after_create :build_payment_and_submission

  has_one :payment, as: :remittance
  belongs_to :actioned_by, class_name: "User"

  validates :payment_date, presence: true
  validates :part, presence: true
  validates :task, presence: true
  validates :payment_amount,
            presence: true, numericality: { greater_than: 0 }

  PAYMENT_TYPES = [
    ["Bacs", :bacs],
    ["Cash", :cash],
    ["Cheque", :cheque],
    ["Client Account", :client_account],
    ["Credit/Debit Card", :card],
    ["Postal Order", :postal_order],
  ].freeze

  private

  def build_payment_and_submission
    Payment.create(
      amount: payment_amount.to_f * 100,
      remittance: self,
      submission: Submission.create(part: part,
                                    task: task,
                                    vessel_reg_no: vessel_reg_no,
                                    officer_intervention_required: true,
                                    source: :manual_entry))
  end
end
