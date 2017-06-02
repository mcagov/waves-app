class FeeSchedule
  def initialize(submission)
    @submission = submission
  end

  def service_level
    if (AccountLedger.new(@submission).amount_paid || 0) + 5000
      :premium
    else
      :standard
    end
  end
end
