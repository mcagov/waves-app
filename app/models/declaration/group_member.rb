class Declaration::GroupMember < ApplicationRecord
  belongs_to :declaration
  belongs_to :declaration_group, class_name: "Declaration::Group"
end
