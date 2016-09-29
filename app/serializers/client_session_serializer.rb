class CountrySerializer < ActiveModel::Serializer
  attributes :id, :recipients

  def recipients
    obfuscated_recipient_phone_numbers
  end
end
