class Declaration::Group < ApplicationRecord
  belongs_to :submission
  has_many :declaration_group_members,
           class_name: "Declaration::GroupMember",
           foreign_key: :declaration_group_id
  has_many :declarations, through: :declaration_group_members

  attr_accessor :default_group_member

  after_create :save_default_group_member

  def save_default_group_member
    if default_group_member
      declaration_group_members.create(declaration_id: default_group_member)
    end
  end
end
