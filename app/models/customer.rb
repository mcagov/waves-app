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

  def alt_inline_address
    alt_compacted_address.join(", ")
  end

  def alt_compacted_address
    [
      alt_address_1,
      alt_address_2,
      alt_address_3,
      alt_town,
      alt_country,
      alt_postcode,
    ].compact.reject(&:empty?)
  end

  def details
    { name: name, inline_address: inline_address }
  end
end
