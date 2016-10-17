class Decorators::Submission < SimpleDelegator
  def initialize(submission)
    @submission = submission
    super
  end

  def editable?
    !completed? && !printing?
  end

  def similar_vessels
    Search.similar_vessels(vessel)
  end
end
