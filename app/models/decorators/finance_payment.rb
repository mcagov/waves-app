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
    DeprecableTask.new(task).description
  end

  def payment_type_description
    Payment::FinancePayment::PAYMENT_TYPES.find do |t|
      t[1] == payment_type.to_sym
    end[0] if payment_type
  end

  def assigned_application_ref_no
    locked? ? submission.ref_no : application_ref_no
  end
end
