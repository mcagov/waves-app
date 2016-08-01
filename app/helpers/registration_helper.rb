module RegistrationHelper
  def inline_address(hsh)
    [
      hsh[:address_1],
      hsh[:address_2],
      hsh[:address_3],
      hsh[:town],
      hsh[:county],
      hsh[:country],
      hsh[:postcode]
    ].compact.reject(&:empty?).join(", ")
  end
end
