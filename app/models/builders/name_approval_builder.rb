class Builders::NameApprovalBuilder
  class << self
    def build(submission, name_approval)
      @submission = submission
      @name_approval = name_approval
      @name_approval.save!

      @submission.update_attribute(:registered_vessel_id, @name_approval.id)
    end
  end
end
