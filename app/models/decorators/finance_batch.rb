class Decorators::FinanceBatch < SimpleDelegator
  def initialize(finance_batch)
    @finance_batch = finance_batch
    super
  end

  def title
    locked? ? "#{batch_no} <i class='fa fa-lock'></i>".html_safe : batch_no
  end

  def open_date
    opened_at.to_s(:date_time) if opened_at
  end

  def closed_date
    closed_at.to_s(:date_time) if closed_at
  end

  def locked_date
    locked_at.to_s(:date_time) if locked_at
  end
end
