class Submission::ShareHolding
  def initialize(submission)
    @submission = submission
  end

  def total
    @submission.declarations.sum(&:shares_held)
  end
end
