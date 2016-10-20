class Decorators::FinancePayment < SimpleDelegator
  include ActionView::Helpers::NumberHelper

  def initialize(finance_payment)
    @finance_payment = finance_payment
    super
  end

  def part_description
    Activity.new(part)
  end

  def task_description
    Task.description(task)
  end

  def formatted_payment_amount
    "£#{number_with_precision(payment_amount.to_f, precision: 2)}"
  end

  def payment_type_description
    Payment::FinancePayment::PAYMENT_TYPES.find do |t|
      t[1] == payment_type.to_sym
    end[0] if payment_type
  end

  def service_level_description
    service_level.titleize if service_level
  end
end
