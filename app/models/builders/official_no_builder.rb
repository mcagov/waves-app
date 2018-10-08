class Builders::OfficialNoBuilder
  class << self
    def build(submission, vessel_reg_no = nil)
      @submission = submission

      @submission.registered_vessel ||=
        Register::Vessel.create(
          name: @submission.vessel.name,
          part: @submission.part,
          reg_no: vessel_reg_no)

      @submission.save
    end

    def update(registered_vessel, vessel_reg_no)
      registered_vessel.update_attributes(reg_no: vessel_reg_no)

      if registered_vessel.current_registration
        registered_vessel.current_registration.update_attribute(
          :registry_info, registered_vessel.registry_info)
      end
    end
  end
end
