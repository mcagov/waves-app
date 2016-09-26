class Customer < ApplicationRecord
  def to_s
    name
  end

  def inline_address
    [
      address_1,
      address_2,
      address_3,
      town,
      country,
      postcode,
    ].compact.reject(&:empty?).join(", ")
  end
end
