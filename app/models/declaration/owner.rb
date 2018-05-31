class Declaration::Owner < Customer
  has_many :declaration_group_members,
           class_name: "Declaration::GroupMember",
           foreign_key: :declaration_owner_id,
           dependent: :destroy

  delegate :registered_owner_id, to: :parent
end
