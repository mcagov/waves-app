class Register::VesselSerializer < ActiveModel::Serializer
  attribute :registry_info
  attribute :registration_status do
    object.registration_status.to_json
  end
end
