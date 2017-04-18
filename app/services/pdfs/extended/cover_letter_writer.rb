class Pdfs::Extended::CoverLetterWriter < Pdfs::CoverLetterWriter
  def write
    @pdf.start_new_page
    init_stationary
    vessel_name
    message
    @pdf
  end

  protected

  def vessel_name
    set_bold_font
    @pdf.draw_text @vessel[:name], at: [l_margin, 530]
  end

  def message
    set_copy_font
    @pdf.formatted_text_box message_text,
                            at: [l_margin, 510],
                            width: 495
  end

  # rubocop:disable all
  def message_text
    [
      "I enclose the certificate in respect of the above ship. It should be kept in a safe place on board (except "\
      "when returned for amendment). Please read carefully the important notes that are to be found on the "\
      "certificate. If you think there may be an error on the certificate you must return it to us with a covering "\
      "note. Do not deface or alter the certificate yourself. I would point out that mortgages on a vessel are "\
      "recorded on the main Register but they are not shown on certificates. If you need details of any "\
      "outstanding mortgages you will need to apply to this office for a transcript which costs £21; cheques should "\
      "be crossed and made payable to 'MCA'.",
      "\n\n",
      "Please note that engine power is shown in kilowatts, which is approximately 3/4 of the engine horsepower.",
      "\n\n",
      "Yours sincerely,",
      "\n\n\n\n",
      @registration.actioned_by.to_s,
      "\n",
      "Registration Officer"
    ].map { |line| { text: line } }
  end
  # rubocop:enable all
end
