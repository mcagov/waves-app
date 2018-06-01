class Declaration::GroupMember < ApplicationRecord
  belongs_to :declaration_owner, class_name: "Declaration::Owner"
  belongs_to :declaration_group, class_name: "Declaration::Group"

  around_destroy :ensure_declaration_group

  private

  def ensure_declaration_group
    @declaration_group = declaration_group

    yield

    if @declaration_group.declaration_group_members.empty?
      @declaration_group.destroy
    end
  end
end
