class Submission::NameReservation
  include ActiveModel::Model

  attr_accessor(
    :name, :registration_type, :port_name, :port_no, :net_tonnage)
end
