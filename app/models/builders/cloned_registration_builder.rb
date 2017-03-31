class Builders::ClonedRegistrationBuilder
  class << self
    def create(submission)
      @submission = submission
      @registered_vessel = @submission.registered_vessel
      @current_registration = @registered_vessel.current_registration

      create_cloned_registration if @current_registration
    end

    private

    def create_cloned_registration
      @current_registration
        .update_attribute(:registry_info, @registered_vessel.registry_info)

      @submission.update_attributes(registration: @current_registration)

      @current_registration
    end
  end
end
