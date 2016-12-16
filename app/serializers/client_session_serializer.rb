class ClientSessionSerializer < ActiveModel::Serializer
  attributes :id, :delivered_to, :customer_id

  def delivered_to
    object.obfuscated_recipient_phone_number
  end
end
