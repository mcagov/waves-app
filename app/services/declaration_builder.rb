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
        declaration.declare! if @declared_by_emails.include?(owner.email)
      end
    end

    def build_outstanding_declaration_notifications
      @submission.declarations.incomplete.each do |declaration|
        declaration.update_attributes(
          notification:
            Notification::OutstandingDeclaration.create(
              submission: @submission)
        )
      end
    end
  end
end
