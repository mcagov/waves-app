class Builders::DeclarationBuilder
  class << self
    def create(submission, owners, declared_by_emails, shareholder_groups)
      @submission = submission
      @owners = owners || []
      @declared_by_emails = declared_by_emails || []
      @shareholder_groups = shareholder_groups || []

      build_declarations
      build_notifications
      build_declaration_groups
    end

    private

    def build_declarations # rubocop:disable Metrics/MethodLength
      @owners.each do |owner|
        declaration =
          Declaration.create(
            submission: @submission,
            changeset: owner,
            state: initial_state_for_task,
            shares_held: owner[:shares_held].to_i,
            entity_type: owner[:entity_type] || :individual)

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

    def build_declaration_groups
      @shareholder_groups.each do |sharedholder_group|
        declaration_group =
          @submission.declaration_groups.create(
            shares_held: sharedholder_group[:shares_held])

        sharedholder_group[:group_members].each do |group_member|
          declaration_group
            .declaration_group_members
            .create(declaration_id: declaration_id_for(group_member))
        end
      end
    end

    def declaration_owners_list
      Declaration.where(submission: @submission).map do |d|
        [d.id, d.owner.email]
      end
    end

    def declaration_id_for(email)
      @declaration_owners_list ||= declaration_owners_list
      declaration_owners_list.find { |owner| owner[1] == email }[0]
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
