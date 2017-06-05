class AccountLedger
  def initialize(submission)
    @submission = submission
    @task = Task.new(submission.task)
  end

  def payment_status
    return :not_applicable unless @task.payment_required?
    return :unpaid if @submission.payments.empty?
    return :paid if amount_paid >= amount_due
    :part_paid
  end

  def amount_due
    @submission
      .line_items.map { |line_item| line_item.price.to_i }
      .inject(:+) || 0
  end

  def amount_paid
    @submission
      .payments.map { |payment| payment.amount.to_i }
      .inject(:+) || 0
  end

  def awaiting_payment?
    ![:not_applicable, :paid].include?(payment_status)
  end

  def balance
    (amount_paid.to_f - amount_due.to_f) / 100
  end
end
