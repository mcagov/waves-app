class Builders::NameApprovalBuilder
  class << self
    def create(submission, name_approval)
      @submission = submission
      @name_approval = name_approval

      @name_approval.name_approved_until = 3.months.from_now

      # sequence numbers to be defined
      @name_approval.reg_no = rand(1..10000)
      # sequence numbers to be defined
      @name_approval.port_no = rand(1..10000) if @name_approval.port_no.blank?

      if @name_approval.valid? && @name_approval.save
        @submission.update_attribute(
          :registered_vessel_id, @name_approval.id)
      end
    end
  end
end
