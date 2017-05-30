class Builders::RegistryBuilder
  class << self
    def create(submission, approval_params)
      @submission = submission
      @approval_params = approval_params

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
      @vessel =
        Builders::Registry::VesselBuilder.create(@submission, @approval_params)
    end

    def assign_vessel_to_submission
      unless @submission.registered_vessel
        @submission.update_attribute(:registered_vessel_id, @vessel.id)
      end
    end

    def builder_associations # rubocop:disable Metrics/MethodLength
      [
        "Builders::Registry::AgentBuilder",
        "Builders::Registry::BeneficialOwnerBuilder",
        "Builders::Registry::DirectedByBuilder",
        "Builders::Registry::DocumentBuilder",
        "Builders::Registry::EngineBuilder",
        "Builders::Registry::ManagerBuilder",
        "Builders::Registry::MortgageBuilder",
        "Builders::Registry::ChartererBuilder",
        "Builders::Registry::OwnerBuilder",
        "Builders::Registry::RepresentativeBuilder",
        "Builders::Registry::ShareBuilder"]
    end

    def build_vessel_associations
      builder_associations.each do |builder_association|
        @vessel =
          builder_association
          .constantize.create(@submission, @vessel, @approval_params)
      end
    end
  end
end
