class Customer < ApplicationRecord
  belongs_to :parent, polymorphic: true

  def to_s
    name
  end

  def inline_address
    compacted_address.join(", ")
  end

  def compacted_address
    [
      address_1,
      address_2,
      address_3,
      town,
      country,
      postcode,
    ].compact.reject(&:empty?)
  end
end
