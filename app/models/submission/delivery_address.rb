class Submission::DeliveryAddress
  include Address
  include VirtualModel

  def inline_name_and_address
    "#{name}, #{inline_address}" if name && !inline_address.empty?
  end
end
