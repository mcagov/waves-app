class Builders::OfficialNoBuilder
  class << self
    def build(submission, vessel_reg_no = nil)
      @submission = submission

      @submission.registered_vessel ||=
        Register::Vessel.create(
          name: @submission.vessel.name,
          part: @submission.part,
          reg_no: vessel_reg_no)

      if Policies::Definitions.fishing_vessel?(@submission)
        @submission = assign_ec_no(@submission)
      end

      @submission.save
    end

    private

    def assign_ec_no(submission)
      vessel = submission.vessel
      vessel.ec_no = "GBR000#{submission.registered_vessel.reg_no}"
      submission.vessel = vessel
      submission
    end
  end
end
