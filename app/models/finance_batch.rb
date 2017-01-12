class FinanceBatch < ApplicationRecord
  belongs_to :processed_by, class_name: "User"
  has_many :finance_payments, foreign_key: :batch_id,
                              class_name: "Payment::FinancePayment"

  protokoll :batch_no, pattern: "1#####"

  def total_amount
    finance_payments.sum(&:payment_amount)
  end

  def toggle_state!
    closed? ? reopen_batch! : close_batch!
  end

  def closed?
    closed_at.present?
  end

  def close_batch!
    update_attributes(closed_at: Time.now)
  end

  def reopen_batch!
    update_attributes(closed_at: nil)
  end
end
