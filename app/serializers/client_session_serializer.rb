class ClientSessionSerializer < ActiveModel::Serializer
  attributes :id, :delivered_to

  def delivered_to
    object.obfuscated_recipient_phone_numbers
  end
end
