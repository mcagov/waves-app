class Builders::NameApprovalBuilder
  class << self
    def create(submission, name_approval)
      @submission = submission
      @name_approval = name_approval

      build_registered_vessel
      assign_name_approved_until
      assign_port_code
      persist_registered_vessel
      assign_submission_changeset

      @submission
    end

    private

    def build_registered_vessel
      @registered_vessel = Register::Vessel.new(
        part: @name_approval.part,
        name: @name_approval.name,
        port_code: @name_approval.port_code,
        port_no: @name_approval.port_no,
        net_tonnage: @name_approval.net_tonnage,
        register_tonnage: @name_approval.register_tonnage,
        registration_type: @name_approval.registration_type)
    end

    def assign_name_approved_until
      @registered_vessel.name_approved_until = 3.months.from_now
    end

    def assign_port_code
      @registered_vessel.port_no ||=
        SequenceNumber::Generator.port_no!(@name_approval.port_code)
    end

    def persist_registered_vessel
      if @registered_vessel.save
        @submission.update_attribute(
          :registered_vessel_id, @registered_vessel.id)
      end
    end

    def assign_submission_changeset
      @submission.changeset = @registered_vessel.registry_info
      @submission.save
    end
  end
end
