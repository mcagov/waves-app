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

  def submission_ref_no
    submission.ref_no if submission
  end

  def submission
    payment.submission
  end

  private

  def build_payment_and_submission
    submission = Submission.create(
      part: part,
      task: task,
      source: :manual_entry
    )

    Payment.create(
      amount: payment_amount.to_f * 100,
      submission: submission,
      remittance: self
    )
  end
end
