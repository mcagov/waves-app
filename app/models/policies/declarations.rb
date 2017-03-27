class Policies::Declarations
  def initialize(submission)
    @submission = submission
  end

  def undeclared?
    !@submission.incomplete_declarations.empty?
  end

  def declaration_status
    if @submission.declarations.empty?
      "Undefined"
    elsif @submission.incomplete_declarations.empty?
      "Complete"
    else
      "Incomplete"
    end
  end
end
