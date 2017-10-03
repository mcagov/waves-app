class Pdfs::RenewalReminderLetterWriter
  include Pdfs::Stationary

  def initialize(registration, pdf)
    @registration = registration
    @vessel = @registration.registered_vessel
    @applicant_name = @vessel.correspondent
    @delivery_name_and_address = @registration.delivery_name_and_address

    @pdf = pdf
  end
end
