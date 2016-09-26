class Declaration::Owner
  include VirtualAddress
  include VirtualModel

  attr_accessor(
    :nationality,
    :email,
    :phone_number,
    :declared_at
  )
end
