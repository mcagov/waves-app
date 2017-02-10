class ShareHolding
  def initialize(submission)
    @submission = submission
  end

  def total
    shares_held_outright + shares_held_jointly
  end

  def status
    if total < 64
      :incomplete
    elsif total == 64
      :complete
    else
      :excessive
    end
  end

  def unallocated
    status == :incomplete ? 64 - total : 0
  end

  private

  def shares_held_outright
    @submission.declarations.sum(&:shares_held)
  end

  def shares_held_jointly
    @submission.declaration_groups.sum(&:shares_held)
  end
end
