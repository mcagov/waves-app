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
      @owners.each_with_index do |owner, i|
        declaration =
          Declaration.create(
            submission: @submission,
            changeset: owner
          )

        if i.zero? && @declared_by_emails.include?(declaration.owner.email)
          declaration.declared!
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
  end
end
