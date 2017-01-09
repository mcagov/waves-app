class Submission::NameReservation
  include ActiveModel::Model

  attr_accessor(
    :part, :name, :registration_type, :port_name, :port_no, :net_tonnage)

  def registration_types
    WavesUtilities::RegistrationType.all.map do |registration_type|
      [registration_type.to_s.humanize, registration_type]
    end
  end

  def ports
    WavesUtilities::Port.all(part)
  end
end
