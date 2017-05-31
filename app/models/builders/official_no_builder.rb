class Builders::OfficialNoBuilder
  class << self
    def build(submission, vessel_reg_no = nil)
      @submission = submission

      @submission.registered_vessel ||=
        Register::Vessel.create(
          name: @submission.vessel.name,
          part: @submission.part,
          reg_no: vessel_reg_no)

      vessel = @submission.vessel
      vessel.ec_no = "GBR000#{@submission.registered_vessel.reg_no}"
      @submission.vessel = vessel

      @submission.save
    end
  end
end
