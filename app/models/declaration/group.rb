class Declaration::Group < ApplicationRecord
  belongs_to :submission
  has_many :declaration_group_members,
           class_name: "Declaration::GroupMember",
           foreign_key: :declaration_group_id
  has_many :declarations, through: :declaration_group_members
end
