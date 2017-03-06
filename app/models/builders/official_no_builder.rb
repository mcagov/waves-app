class Builders::OfficialNoBuilder
  class << self
    def build(submission)
      @submission = submission

      @submission.registered_vessel ||=
        Register::Vessel.create(
          name: @submission.vessel.name, part: @submission.part)

      @submission.save
    end
  end
end
