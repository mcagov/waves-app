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

  def active?
    name.present? && address_1.present? && postcode.present?
  end
end
