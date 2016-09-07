class DeclarationBuilder
  class << self
    def build(submission, owners, declared_by_emails)
      @submission = submission
      @owners = owners || []
      @declared_by_emails = declared_by_emails || []
      build_declarations
      build_outstanding_declaration_notifications
    end

    private

    def build_declarations
      @owners.each do |owner|
        declaration =
          Declaration.create(
            submission: @submission,
            changeset: owner
          )
        if @declared_by_emails.include?(declaration.owner.email)
          declaration.declared!
        end
      end
    end

    def build_outstanding_declaration_notifications
      @submission.declarations.incomplete.each do |declaration|
        Notification::OutstandingDeclaration.create(
          notifiable: declaration)
      end
    end
  end
end
