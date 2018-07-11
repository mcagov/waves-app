class Service < ApplicationRecord
  scope :in_part, ->(part) { where.not(part.to_sym => nil) }

  def to_s
    name
  end

  def standard_price(part)
    pence(price(part)[:standard])
  end

  def premium_price(part)
    premium_supplement(part) + standard_price(part) if premium_supplement(part)
  end

  def premium_supplement(part)
    pence(price(part)[:premium])
  end

  def subsequent_price(part)
    pence(price(part)[:subsequent])
  end

  private

  def price(part)
    (send(part) || {}).symbolize_keys
  end

  def pence(amount)
    return unless amount
    amount * 100
  end
end
