class FinanceBatch < ApplicationRecord
  belongs_to :processed_by, class_name: "User"
  has_many :finance_payments, foreign_key: :batch_id,
                              class_name: "Payment::FinancePayment"

  protokoll :batch_no, pattern: "1#####"

  include ActiveModel::Transitions

  state_machine do
    state :open, timestamp: :opened_at
    state :closed
    state :locked

    event :close!, timestamp: :closed_at do
      transitions to: :closed, from: [:open]
    end

    event :re_open! do
      transitions to: :open, from: [:closed],
                  on_transition: :unset_closed_at!
    end

    event :lock!, timestamp: :locked_at do
      transitions to: :locked, from: [:closed],
                  on_transition: :lock_dependencies!
    end
  end

  def lock_dependencies!
    finance_payments.map(&:lock!)
  end

  def total_amount
    finance_payments.sum(&:payment_amount)
  end

  def unset_closed_at!
    update_attributes(closed_at: nil)
  end
end
