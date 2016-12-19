class Builders::DeclarationBuilder
  class << self
    def create(submission, owners, declared_by_emails)
      @submission = submission
      @owners = owners || []
      @declared_by_emails = declared_by_emails || []
      build_declarations
      build_notifications
    end

    private

    def build_declarations
      @owners.each do |owner|
        declaration =
          Declaration.create(
            submission: @submission,
            changeset: owner,
            state: initial_state_for_task)

        if @declared_by_emails.include?(declaration.owner.email)
          declaration.declared! if declaration.can_transition? :declared
        end
      end
    end

    def build_notifications
      @submission.declarations.incomplete.each do |declaration|
        Notification::OutstandingDeclaration.create(
          recipient_name: declaration.owner.name,
          recipient_email: declaration.owner.email,
          notifiable: declaration)
      end
    end

    def initial_state_for_task
      if Task.new(@submission.task).declarations_required_on_create?
        :incomplete
      else
        :not_required
      end
    end
  end
end
