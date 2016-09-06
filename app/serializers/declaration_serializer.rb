class DeclarationSerializer < ActiveModel::Serializer
  attributes :owner, :other_owners, :vessel
end
