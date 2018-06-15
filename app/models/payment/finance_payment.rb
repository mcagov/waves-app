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

  scope :unattached, (lambda do
    joins(:payment).where("payments.submission_id is null")
  end)

  scope :in_part, ->(part) { where(part: part.to_sym) }

  enum service_level: [:standard, :premium]

  PAYMENT_TYPES = [
    ["BACS", :bacs],
    ["CARD", :card],
    ["CASH", :cash],
    ["CHAPS", :chaps],
    ["CHEQUE", :cheque],
    ["CLIENT ACCOUNT", :client_account],
    ["POSTAL ORDER", :postal_order],
    ["PRE-WAVES", :pre_waves],
    ["ROLLING ACCOUNT", :rolling_account],
    ["WORLD PAY", :world_pay],
    ["ADMIN", :admin],
  ].freeze

  def lock!
    build_payment
  end

  def locked?
    payment.present?
  end

  def searchable_attributes
    [
      :vessel_name,
      :applicant_name,
      :application_ref_no,
    ].map { |attr| send(attr) }.join(" ")
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

  def build_payment
    Payment.create(
      amount: payment_amount.to_f * 100,
      remittance: self)
  end
end
