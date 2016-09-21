class Declaration::Owner
  include Address

  attr_accessor(
    :nationality,
    :email,
    :phone_number,
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
end
