class ApplicationProcessor
  class << self
    def run(task, approval_params)
      @task = task
      @submission = @task.submission
      @approval_params = approval_params

      @registered_vessel = assign_registered_vessel
      @registration = assign_registration

      build_print_jobs
    end

    private

    def assign_registered_vessel
      if activities_policy.update_registry_details
        Builders::RegistryBuilder.create(@submission, @approval_params)
      else
        @submission.registered_vessel
      end
    end

    def assign_registration # rubocop:disable Metrics/MethodLength
      if activities_policy.generate_new_5_year_registration
        generate_registration
      elsif activities_policy.generate_provisional_registration
        generate_registration(provisional: true)
      elsif activities_policy.record_transcript_event
        record_transcript_event
      elsif activities_policy.close_registration
        close_registration
      elsif activities_policy.restore_closure
        restore_closure
      else
        @registered_vessel.try(:current_registration)
      end
    end

    def generate_registration(provisional: false)
      Builders::RegistrationBuilder
        .create(
          @task,
          @registered_vessel,
          @approval_params[:registration_starts_at],
          @approval_params[:registration_ends_at],
          provisional)
    end

    def record_transcript_event
      return unless @registered_vessel.current_registration

      Builders::RegistrationBuilder
        .create(
          @task,
          @registered_vessel,
          @registered_vessel.current_registration.registered_at,
          @registered_vessel.current_registration.registered_until,
          @registered_vessel.current_registration.provisional?)
    end

    def close_registration
      Builders::ClosedRegistrationBuilder
        .create(
          @task,
          @approval_params[:closure_at],
          @approval_params[:closure_reason],
          @approval_params[:supporting_info])
    end

    def restore_closure
      Builders::RestoreClosureBuilder.create(
        @task,
        @approval_params[:registration_starts_at],
        @approval_params[:registration_ends_at])
    end

    def build_print_jobs
      @task.service.print_templates.each do |print_template|
        PrintJob.create(
          submission: @submission,
          printable: printable_for(print_template),
          part: @submission.part,
          template: print_template,
          added_by: @task.claimant)
      end
    end

    def printable_for(template)
      template.to_sym == :csr_form ? @submission.csr_form : @registration
    end

    def activities_policy
      Policies::Activities.new(@task)
    end
  end
end
