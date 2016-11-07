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
    Task.new(@submission.task).payment_required? ? 2500 : 0
  end

  def amount_paid
    @submission.payments.sum(&:amount).to_i
  end

  def awaiting_payment?
    ![:not_applicable, :paid].include?(payment_status)
  end

  def service_level
    amount_paid == 7500 ? :urgent : :standard
  end
end
