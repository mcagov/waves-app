class Submission::ApplicationProcessor
  class << self
    def run(submission, registration_starts_at)
      @submission = submission

      Builders::RegistryBuilder.create(@submission)
      Builders::RegistrationBuilder.create(@submission, registration_starts_at)
    end
  end
end
