class Register::VesselSerializer < ActiveModel::Serializer
  attributes :registry_info, :registration_status
end
