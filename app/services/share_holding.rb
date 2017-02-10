class ShareHolding
  def initialize(submission)
    @submission = submission
  end

  def total
    shares_held_outright + shares_held_jointly
  end

  def complete?

  end

  def invalid?

  end

  private

  def shares_held_outright
    @submission.declarations.sum(&:shares_held)
  end

  def shares_held_jointly
    @submission.declaration_groups.sum(&:shares_held)
  end
end
