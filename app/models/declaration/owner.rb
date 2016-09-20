class Declaration::Owner
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
    :country,
    :declared_at
  )

  def initialize(params = {})
    params.reject! { |param| !respond_to?(param) }
    assign_attributes(params)
  end

  def to_s
    name
  end

  def assign_attributes(params = {})
    params.each { |key, value| instance_variable_set("@#{key}", value) }
  end

  def inline_address
    [
      address_1,
      address_2,
      town,
      country,
      postcode,
    ].compact.reject(&:empty?).join(", ")
  end
end
