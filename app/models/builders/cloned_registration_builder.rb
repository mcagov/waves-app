class Builders::ClonedRegistrationBuilder
  class << self
    def create(submission)
      @submission = submission
      @registered_vessel = @submission.registered_vessel

      create_cloned_registration
    end

    private

    def create_cloned_registration
      registration = @registered_vessel.current_registration

      registration
        .update_attribute(:registry_info, @registered_vessel.registry_info)

      @submission.update_attributes(registration: registration)

      registration
    end
  end
end
