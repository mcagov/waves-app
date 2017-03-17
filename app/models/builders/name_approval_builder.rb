class Builders::NameApprovalBuilder
  class << self
    def create(submission, name_approval)
      @submission = submission
      @name_approval = name_approval

      init_defaults
      assign_submission_changeset

      @name_approval.save
    end

    private

    def init_defaults
      @name_approval.approved_until ||= 3.months.from_now

      if Policies::Workflow.uses_port_no?(@submission)
        @name_approval.port_no ||=
          SequenceNumber::Generator.port_no!(@name_approval.port_code)
      else
        @name_approval.port_no = nil
      end

      @name_approval.submission = @submission
    end

    def assign_submission_changeset
      vessel = @submission.vessel
      vessel.name = @name_approval.name
      vessel.port_no = @name_approval.port_no
      vessel.port_code = @name_approval.port_code
      vessel.registration_type = @name_approval.registration_type
      @submission.vessel = vessel
      @submission.save
    end
  end
end
