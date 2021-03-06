class Policies::Declarations
  def initialize(submission)
    @submission = submission
  end

  def declarable_items
    @declarable_items =
      if Policies::Definitions.part_4?(@submission)
        @submission.charter_parties
      else
        @submission.declarations
      end
  end

  def incomplete?
    !declarable_items.incomplete.empty?
  end

  def undefined?
    declarable_items.empty?
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
