class Builders::RegistryBuilder
  class << self
    def create(submission)
      @submission = submission

      perform

      @vessel
    end

    private

    def perform
      Register::Vessel.transaction do
        build_vessel
        assign_vessel_to_submission
        build_vessel_associations
      end
    end

    def build_vessel
      @vessel = Builders::Registry::VesselBuilder.create(@submission)
    end

    def assign_vessel_to_submission
      unless @submission.registered_vessel
        @submission.update_attribute(:registered_vessel_id, @vessel.id)
      end
    end

    def build_vessel_associations
      @vessel = Builders::Registry::OwnerBuilder.create(@submission, @vessel)
      @vessel = Builders::Registry::AgentBuilder.create(@submission, @vessel)
      @vessel = Builders::Registry::ShareBuilder.create(@submission, @vessel)
      @vessel = Builders::Registry::EngineBuilder.create(@submission, @vessel)
    end
  end
end
