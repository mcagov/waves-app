class AccountLedger
  def initialize(submission)
    @submission = submission
    @task = DeprecableTask.new(submission.task)
  end

  def ui_color
    case payment_status
    when :not_applicable then "default"
    when :unpaid then "danger"
    when :part_paid then "info"
    when :paid then "success"
    end
  end

  def payment_status
    return :not_applicable unless @task.payment_required?
    return :unpaid if @submission.payments.empty?
    return :paid if amount_paid >= amount_due
    :part_paid
  end

  def amount_due
    @submission
      .line_items.map { |line_item| line_item.subtotal.to_i }
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
