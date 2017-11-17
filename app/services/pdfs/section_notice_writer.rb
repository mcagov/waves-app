# rubocop:disable all
class Pdfs::SectionNoticeWriter
  include Pdfs::Stationary

  def initialize(section_notice, pdf)
    @section_notice = section_notice
    @vessel = @section_notice.noteable

    @pdf = pdf
  end

  def write
    @vessel.owners.each do |owner|
      @pdf.start_new_page
      @applicant_name = owner.name
      @delivery_name_and_address = [owner.name] + owner.compacted_address
      init_stationary(@section_notice.updated_at)
      vessel_name
      page_one
      @pdf.start_new_page
      page_two(owner)
    end
    @pdf
  end

  protected

  def vessel_name
    set_bold_font
    msg = [@vessel.vessel_type]
    msg << @vessel.name
    msg << @vessel.reg_no
    @pdf.text_box "RE: #{msg.compact.join(", ")}",
                  at: [l_margin, 530],
                  width: 480, height: 100, leading: 8

  end

  def page_one
    set_copy_font
    msg = "I am writing to you as the registered owner of the above mentioned vessel."
    msg += "\n\n"
    msg += "It has been brought to the attention of the Registrar General of Shipping and Seamen that the vessel named "
    msg += " #{@vessel.name}, #{@vessel.reg_no}"
    msg += " is no longer eligible to be registered as a"
    msg += " #{@vessel.vessel_type}"
    msg += " due to:\n\n"
    msg += "Regulation #{@section_notice.subject}."
    msg += "\n\n"
    msg += "I am therefore enclosing a notice issued under regulation 101(1) of the"
    msg += " Regulations, which tells you to present to the Registrar evidence that the vessel is eligible to remain on the Register."
    msg += "\n\n"
    msg += "Failure to comply with the notice will lead to termination of the vessel’s registration."
    msg += "\n\n"
    msg += "If you accept that the vessel is no longer eligible for registration please confirm in writing."
    msg += "\n\n"
    msg += "Yours sincerely,"
    msg += "\n\n\n\n"
    msg += @section_notice.actioned_by.to_s
    msg += "\n"
    msg += "Registration Officer"

    @pdf.text_box msg,
                  at: [l_margin, 510],
                  width: 480, height: 400, leading: 4
  end

  def page_two(owner)
    set_bold_font
    msg = "NOTICE PURSUANT TO REGULATION 101 OF THE MERCHANT SHIPPING (REGISTRATION) REGULATIONS 1993 (as amended)"
    @pdf.text_box msg,
                  at: [l_margin, 780],
                  width: 480, height: 100, leading: 8

    set_copy_font
    msg = "To: #{owner.name}\n"
    msg += "Of: #{owner.inline_address}"
    @pdf.text_box msg,
                  at: [l_margin, 720],
                  width: 480, height: 100, leading: 8

    msg = "\n\nThe Registrar General of Shipping and Seamen considers that regulation"
    msg += " #{@section_notice.regulation_key} of the Merchant Shipping (Registration)"
    msg += " Regulations 1993 (as amended) applies to the vessel named"
    msg += " #{@vessel.name}, Official number #{@vessel.reg_no}."
    msg += "\n\n"
    msg += "You must therefore send the Registrar within 30 days of the date of this notice evidence that the vessel is eligible to remain on the Register."
    msg += " This evidence should include:"
    msg += "\n\n - #{@section_notice.content}"
    msg += "\n\n If at the expiry of 30 days the Registrar is not satisfied that the vessel is eligible to remain on the Register the Registrar may:"
    msg += "\n\n - (a) extend the notice and ask for further information or evidence"
    msg += "\n or"
    msg += "\n - (b) serve a final notice which will close the vessel’s registration. The closure will take place 7 days after the service of that notice."
    msg += "\n\n"
    msg += "Signed:"
    msg += "\n\n\n\n\n\n"
    msg += @section_notice.actioned_by.to_s
    msg += "\nDated: #{@section_notice.updated_at}"
    msg += "\nFor and on behalf of the Registrar General of Shipping and Seamen"
    msg += "\n\n"
    @pdf.text_box msg,
                  at: [l_margin, 660],
                  width: 480, height: 500, leading: 4
    set_bold_font
    msg = "\n\nPlease note:- If you intend to contest this notice you are advised to contact a solicitor without delay."
    @pdf.text_box msg,
                  at: [l_margin, 160],
                  width: 480, height: 400, leading: 4

  end
end
# rubocop:enable all
