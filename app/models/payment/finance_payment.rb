class Payment::FinancePayment < ApplicationRecord
  self.table_name = "finance_payments"

  delegate :submission, to: :payment
  delegate :batch_no, to: :batch

  has_one :payment, as: :remittance
  belongs_to :actioned_by, class_name: "User"
  belongs_to :batch, class_name: "FinanceBatch"

  validates :payment_date, presence: true
  validates :part, presence: true
  validates :task, presence: true
  validates :payment_amount, numericality: { other_than: 0 }

  validate :registered_vessel_exists

  scope :payments, -> { where("payment_amount > 0") }
  scope :refunds, -> { where("payment_amount < 0") }

  enum service_level: [:standard, :premium]

  PAYMENT_TYPES = [
    ["BACS", :bacs],
    ["CHQ", :cheque],
    ["CASH", :cash],
    ["CLIENT ACCOUNT", :client_account],
    ["CHAPS", :chaps],
    ["PO", :postal_order],
    ["CARD", :card],
  ].freeze

  def lock!
    build_payment_and_submission
  end

  def locked?
    payment.present?
  end

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
      part: part, task: task, vessel_reg_no: vessel_reg_no,
      officer_intervention_required: true,
      source: :manual_entry,
      applicant_name: applicant_name,
      applicant_email: applicant_email,
      applicant_is_agent: applicant_is_agent,
      documents_received: documents_received,
      service_level: service_level,
      linkable_ref_no: application_ref_no)
  end
end
