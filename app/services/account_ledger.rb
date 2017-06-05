class AccountLedger
  def initialize(submission)
    @submission = submission
  end

  def payment_status
    return :not_applicable if amount_due.zero?
    return :unpaid if @submission.payments.empty?
    return :paid if amount_paid >= amount_due
    :part_paid
  end

  def amount_due
    0
  end

  def amount_paid
    @submission.payments.map { |payment| payment.amount.to_i }.inject(:+)
  end

  def awaiting_payment?
    ![:not_applicable, :paid].include?(payment_status)
  end

  def balance
    (amount_paid.to_f - amount_due.to_f) / 100
  end
end
