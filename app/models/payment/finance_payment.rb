class Payment::FinancePayment < ApplicationRecord
  self.table_name = "finance_payments"

  delegate :submission, to: :payment

  after_create :build_payment_and_submission

  has_one :payment, as: :remittance
  belongs_to :actioned_by, class_name: "User"

  validates :payment_date, presence: true
  validates :part, presence: true
  validates :task, presence: true
  validates :payment_amount,
            presence: true, numericality: { greater_than: 0 }

  validate :registered_vessel_exists

  PAYMENT_TYPES = [
    ["BACS", :bacs],
    ["CHQ", :cheque],
    ["CASH", :cash],
    ["CHAPS", :chaps],
    ["PO", :postal_order],
    ["CARD", :card],
  ].freeze

  private

  def registered_vessel_exists
    return unless vessel_reg_no.present?

    unless Register::Vessel.in_part(part).find_by(reg_no: vessel_reg_no)
      errors.add(
        :vessel_reg_no,
        "was not found in the #{Activity.new(part)} Registry")
    end
  end

  def build_payment_and_submission
    Payment.create(
      amount: payment_amount.to_f * 100,
      remittance: self,
      submission: build_submission)
  end

  def build_submission
    Submission.create(
      part: part,
      task: task,
      vessel_reg_no: vessel_reg_no,
      officer_intervention_required: true,
      source: :manual_entry)
  end
end
