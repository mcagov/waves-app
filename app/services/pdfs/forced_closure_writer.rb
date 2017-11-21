# rubocop:disable all
class Pdfs::ForcedClosureWriter
  include Pdfs::Stationary

  def initialize(registration, pdf)
    @registration = registration
    @vessel = @registration.vessel
    @applicant_name = @vessel.correspondent.name
    address = @vessel.correspondent.try(:compacted_address)
    @delivery_name_and_address = [@applicant_name] + address
    @pdf = pdf
  end

  def write
    @pdf.start_new_page
    init_stationary(@registration.created_at)
    vessel_name
    message
    @pdf
  end

  protected

  def vessel_name
    set_bold_font
    msg = [@vessel.vessel_type]
    msg << @vessel.name
    msg << @vessel.reg_no
    @pdf.text_box "RE: #{msg.compact.join(', ')}",
                  at: [l_margin, 530],
                  width: 480, height: 100, leading: 8
  end

  def message
    set_copy_font
    msg = "Please find enclosed a Transcript of Closed Registry of a British Ship for the above mentioned vessel."
    msg += "\n\n"
    msg += "As we have not received an application to renew the Certificate of Registry, which ceased to be valid on"
    msg += " #{@registration.registered_until}"
    msg += " the registration of this vessel was terminated on the date shown on the Transcript of Closed Registry of a British ship."
    msg += "\n\n"
    msg += "Please do not hesitate in contacting the Registry of Shipping and Seamen if you have any further queries regarding this matter, or if you wish to re-register your vessel"
    msg += "\n\n"
    msg += "Yours sincerely,"
    msg += "\n\n\n\n"
    msg += @registration.actioned_by.to_s
    msg += "\n"
    msg += "Registration Officer"

    @pdf.text_box msg,
                  at: [l_margin, 510],
                  width: 480, height: 400, leading: 4
  end
end
# rubocop:enable all
