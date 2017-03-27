class Policies::Declarations
  def initialize(submission)
    @submission = submission
  end

  def incomplete?
    !@submission.declarations.incomplete.empty?
  end

  def undefined?
    @submission.declarations.empty?
  end

  def declaration_status
    if undefined?
      "Undefined"
    elsif incomplete?
      "Incomplete"
    else
      "Complete"
    end
  end
end
