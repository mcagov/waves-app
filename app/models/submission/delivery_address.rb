class Submission::DeliveryAddress
  include VirtualAddress
  include VirtualModel

  def inline_name_and_address
    "#{name}, #{inline_address}" if name && !inline_address.empty?
  end
end
