# rubocop:disable all
class Pdfs::TerminationNoticeWriter
  include Pdfs::Stationary

  def initialize(termination_notice, pdf)
    @termination_notice = termination_notice
    @vessel = @termination_notice.vessel

    @pdf = pdf
  end

  def write
    @termination_notice.recipients.each do |recipient|
      @pdf.start_new_page
      @applicant_name = recipient[0]
      @delivery_name_and_address = recipient
      init_stationary(@termination_notice.created_at)
      vessel_name
      page_one
      @pdf.start_new_page
      page_two(recipient)

      @pdf = Pdfs::SectionNoticeWriter.new(@termination_notice.related_section_notice, @pdf).write
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
    msg = "I am writing to you further to my letter of #{@termination_notice.created_at}"
    msg += "\n\nI have attached a copy of the letter sent."
    msg += "\n\nAs I have received no response to that letter, I am now enclosing a notice to"
    msg += " inform you that the registration of the vessel will close on"
    msg += " #{@termination_notice.created_at.advance(days: 7)}."
    msg += "\n\nYour registration of this vessel will cease to be valid from this date."
    msg += "\n\n"
    msg += "Yours sincerely,"
    msg += "\n\n\n\n"
    msg += @termination_notice.actioned_by.to_s
    msg += "\n"
    msg += "Registration Officer"

    @pdf.text_box msg,
                  at: [l_margin, 510],
                  width: 480, height: 400, leading: 4
  end

  def page_two(recipient)
    set_bold_font
    msg = "NOTICE PURSUANT TO REGULATION 101 OF THE MERCHANT SHIPPING (REGISTRATION) REGULATIONS 1993 (as amended)"
    @pdf.text_box msg,
                  at: [l_margin, 780],
                  width: 480, height: 100, leading: 8

    set_copy_font
    msg = "To: #{recipient.shift}\n"
    msg += "Of: #{recipient.join(", ")}"
    @pdf.text_box msg,
                  at: [l_margin, 720],
                  width: 480, height: 100, leading: 8

    msg = "\n\nI am writing further to the Notice dated"
    msg += " #{@termination_notice.created_at} sent on behalf of the Registrar General of Shipping"
    msg += " and Seaman, under regulation 101(1) of the Merchant Shipping (Registration of Ships)"
    msg += " Regulations 1993 (the regulations); to inform you that you have failed to satisfy him"
    msg += " that the vessel #{@vessel.name}, Official number #{@vessel.reg_no} is eligible to be"
    msg += " registered as a UK vessel."
    msg += "\n\nLetter of #{@termination_notice.created_at} enclosed."
    msg += "\n\nAccordingly, the vessel's registration will terminate on"
    msg += " #{@termination_notice.termination_date} by virtue of regulation"
    msg += " #{@termination_notice.regulation_key} of the regulations."
    msg += "\n\n"
    msg += "Signed:"
    msg += "\n\n\n\n\n\n"
    msg += @termination_notice.actioned_by.to_s
    msg += "\nDated: #{@termination_notice.created_at}"
    msg += "\nFor and on behalf of the Registrar General of Shipping and Seamen"

    @pdf.text_box msg,
                  at: [l_margin, 660],
                  width: 480, height: 500, leading: 4
  end
end
# rubocop:enable all
