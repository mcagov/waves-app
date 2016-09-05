class Owner
  include ActiveModel

  attr_accessor(
    :name,
    :nationality,
    :email,
    :phone_number,
    :address_1,
    :address_2,
    :address_3,
    :town,
    :county,
    :postcode,
    :country
  )

  def initialize(params = {})
    params.reject! { |param| !respond_to?(param) }
    params.each { |key, value| instance_variable_set("@#{key}", value) }
  end

  def to_s
    name
  end

  def inline_address
    [
      address_1,
      address_2,
      address_3,
      town,
      county,
      country,
      postcode,
    ].compact.reject(&:empty?).join(", ")
  end
end
