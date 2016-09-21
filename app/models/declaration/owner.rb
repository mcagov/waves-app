class Declaration::Owner
  include Address
  include VirtualModel

  attr_accessor(
    :nationality,
    :email,
    :phone_number,
    :declared_at
  )
end
