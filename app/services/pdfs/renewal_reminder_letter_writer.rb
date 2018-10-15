class Pdfs::RenewalReminderLetterWriter
  include Pdfs::Stationary

  def initialize(registration, pdf)
    @registration = registration
    @vessel = @registration.registered_vessel
    @applicant_name = @vessel.correspondent
    @applicant_name = @vessel.correspondent.name
    address = @vessel.correspondent.try(:compacted_address)
    @delivery_name_and_address = [@applicant_name] + address
    @pdf = pdf
  end
end
