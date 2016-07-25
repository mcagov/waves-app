class OwnerInfo
  include ActiveModel::Model
  include OwnerValidations
  include AddressValidations

  attr_accessor(
    :title,
    :title_other,
    :first_name,
    :last_name,
    :nationality,
    # --- address
    :address_1,
    :address_2,
    :address_3,
    :town,
    :county,
    :postcode,
    :country,
    :email,
    :phone_number,
    :additional_owner
  )

  def full_name_with_title
    "#{title} #{first_name} #{last_name}"
  end
end
