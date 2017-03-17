class Builders::Registry::ManagerBuilder
  class << self
    def create(submission, vessel)
      @submission = submission
      @vessel = vessel

      perform

      @vessel.reload
    end

    private

    def perform
      @vessel.managers.delete_all
      @submission.managers.each do |submission_manager|
        build_manager(submission_manager)
      end
    end

    def build_manager(submission_manager) # rubocop:disable Metrics/MethodLength
      vessel_manager = @vessel.managers.create(
        name: submission_manager.name,
        imo_number: submission_manager.imo_number,
        email: submission_manager.email,
        phone_number: submission_manager.phone_number,
        address_1: submission_manager.address_1,
        address_2: submission_manager.address_2,
        address_3: submission_manager.address_3,
        town: submission_manager.town,
        postcode: submission_manager.postcode,
        country: submission_manager.country)

      build_safety_management_for(vessel_manager, submission_manager)
    end

    def build_safety_management_for(vessel_manager, submission_manager)
      return unless submission_manager.safety_management

      SafetyManagement.create(
        parent: vessel_manager,
        address_1: submission_manager.safety_management.address_1,
        address_2: submission_manager.safety_management.address_2,
        address_3: submission_manager.safety_management.address_3,
        town: submission_manager.safety_management.town,
        postcode: submission_manager.safety_management.postcode,
        country: submission_manager.safety_management.country)
    end
  end
end
