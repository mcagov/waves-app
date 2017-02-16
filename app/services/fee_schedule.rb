class FeeSchedule < WavesUtilities::FeeSchedule
  def initialize(submission)
    @submission = submission
    @part = @submission.part.to_sym
  end

  def standard_fee_required
    FeeSchedule.standard_fee(@part)
  end

  def premium_fee_required
    FeeSchedule.premium_fee(@part)
  end

  def service_level
    if AccountLedger.new(@submission).amount_paid == premium_fee_required
      :premium
    else
      :standard
    end
  end
end
