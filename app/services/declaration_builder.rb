class DeclarationBuilder
  class << self
    def build(submission, owners, declared_by)
      @submission = submission
      @owners = owners || []
      @declared_by = declared_by || []
      find_or_create_declarations
      declare_completed_declarations
      build_outstanding_declaration_notifications
    end

    private

    def find_or_create_declarations
      @owners.map do |owner|
        Declaration.find_or_create_by(
          submission: @submission,
          owner_email: owner
        )
      end
    end

    def declare_completed_declarations
      @declared_by.each do |declarer|
        Declaration.find_by(
          submission: @submission,
          owner_email: declarer).declare!
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
