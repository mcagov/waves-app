class Builders::ManualEntryBuilder
  attr_reader :submission

  def initialize(part, task, vessel_reg_no, claimant)
    @submission = Submission.new(part: part, task: task)
    @submission.vessel_reg_no = vessel_reg_no
    @submission.claimant = claimant
    @submission.state = :assigned
    @submission.source = :manual_entry
  end
end
