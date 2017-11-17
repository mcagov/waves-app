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
      message
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
                  at: [l_margin, 540],
                  width: 480, height: 100, leading: 8

  end

  def message
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

    @pdf.text_box msg,
                  at: [l_margin, 510],
                  width: 480, height: 400, leading: 4
  end
end
