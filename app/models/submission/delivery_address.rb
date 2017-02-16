class Submission::DeliveryAddress < WavesUtilities::DeliveryAddress
  def stationary_name_and_address
    [
      name,
      address_1,
      address_2,
      address_3,
      town,
      country,
      postcode,
    ].compact.reject(&:empty?)
  end

  def exists?
    stationary_name_and_address.present?
  end
end
