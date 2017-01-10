class Builders::NameApprovalBuilder
  class << self
    def create(submission, name_approval)
      @submission = submission
      @name_approval = name_approval

      @name_approval.name_approved_until = 3.months.from_now
      @name_approval.reg_no =
        SequenceNumber::Generator.reg_no!(@name_approval.part)

      # port numbers to be defined
      @name_approval.port_no = rand(1..100) unless @name_approval.port_no.blank?

      if @name_approval.valid? && @name_approval.save
        @submission.update_attribute(
          :registered_vessel_id, @name_approval.id)
      end
    end
  end
end
