class DeliveryAddress
  include ActiveModel::Model
  include AddressValidations

  attr_accessor(
    :address_1,
    :address_2,
    :address_3,
    :town,
    :county,
    :postcode,
    :country
  )
end
