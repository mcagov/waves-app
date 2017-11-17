# rubocop:disable all
class Pdfs::TerminationNoticeWriter
  include Pdfs::Stationary

  def initialize(section_notice, pdf)
    @section_notice = section_notice
    @vessel = @section_notice.vessel

    @pdf = pdf
  end

  def write
    @vessel.owners.each do |owner|
      @pdf.start_new_page
      @applicant_name = owner.name
      @delivery_name_and_address = [owner.name] + owner.compacted_address
      init_stationary(@section_notice.termination_notice_date)
      vessel_name
      page_one
      @pdf.start_new_page
      page_two(owner)

      @pdf = Pdfs::SectionNoticeWriter.new(@section_notice, @pdf).write
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
    msg = "I am writing to you further to my letter of #{@section_notice.section_notice_date}"
    msg += "\n\nI have attached a copy of the letter sent."
    msg += "\n\nAs I have received no response to that letter, I am now enclosing a notice to"
    msg += " inform you that the registration of the vessel will close on"
    msg += " #{@section_notice.termination_notice_date.advance(days: 7)}."
    msg += "\n\nYour registration of this vessel will cease to be valid from this date."
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

    msg = "\n\nI am writing further to the Notice dated"
    msg += " #{@section_notice.section_notice_date} sent on behalf of the Registrar General of Shipping"
    msg += " and Seaman, under regulation 101(1) of the Merchant Shipping (Registration of Ships)"
    msg += " Regulations 1993 (the regulations); to inform you that you have failed to satisfy him"
    msg += " that the vessel #{@vessel.name}, Official number #{@vessel.reg_no} is eligible to be"
    msg += " registered as a UK vessel."
    msg += "\n\nLetter of #{@section_notice.section_notice_date} enclosed."
    msg += "\n\nAccordingly, the vessel's registration will terminate on"
    msg += " #{@section_notice.termination_date} by virtue of regulation"
    msg += " #{@section_notice.regulation_key} of the regulations."
    msg += "\n\n"
    msg += "Signed:"
    msg += "\n\n\n\n\n\n"
    msg += @section_notice.actioned_by.to_s
    msg += "\nDated: #{@section_notice.termination_notice_date}"
    msg += "\nFor and on behalf of the Registrar General of Shipping and Seamen"

    @pdf.text_box msg,
                  at: [l_margin, 660],
                  width: 480, height: 500, leading: 4
  end
end
# rubocop:enable all
