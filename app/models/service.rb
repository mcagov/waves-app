class Service < ApplicationRecord
  scope :in_part, ->(part) { where.not(part.to_sym => nil) }

  def to_s
    name
  end

  def standard_price(part)
    price(part)[:standard]
  end

  def premium_supplement(part)
    price(part)[:premium]
  end

  def subsequent_price(part)
    price(part)[:subsequent]
  end

  private

  def price(part)
    (send(part) || {}).symbolize_keys
  end
end
