class FeeSchedule
  def initialize(submission)
    @submission = submission
  end

  def standard_fee_required
    FeeSchedule.standard_fee(@submission.part.to_sym, @submission.task.to_sym)
  end

  def premium_fee_required
    FeeSchedule.premium_fee(@submission.part.to_sym, @submission.task.to_sym)
  end

  def service_level
    if AccountLedger.new(@submission).amount_paid == premium_fee_required
      :premium
    else
      :standard
    end
  end

  class << self
    def standard_fee(_part = :part_3, _task = :new_registration)
      2500
    end

    def premium_fee(part = :part_3, task = :new_registration)
      standard_fee(part, task) + 5000
    end
  end
end
