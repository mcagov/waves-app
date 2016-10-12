class CoverLetterWriter
  def initialize(registration, pdf)
    @registration = registration
    @vessel = @registration.vessel
    @correspondent = @vessel.owners.first
    @pdf = pdf
  end

  def write
    @pdf.start_new_page
    mca_address
    date_and_ref
    correspondent_address
    greeting
    vessel_name
    message
    @pdf
  end

  protected

  def mca_address
    set_bold_font
    @pdf.draw_text "UK Ship Register", at: [340, 780]
    @pdf.draw_text "Anchor Court", at: [340, 766]
    @pdf.draw_text "KEEN ROAD", at: [340, 752]
    @pdf.draw_text "Cardiff", at: [340, 738]
    @pdf.draw_text "CF24 5JW", at: [340, 724]

    @pdf.draw_text "Tel: 029 2044 8800", at: [340, 700]
    @pdf.draw_text "Fax: 029 2044 8820", at: [340, 686]
  end

  def date_and_ref
    set_bold_font
    @pdf.draw_text "Your Ref:", at: [340, 662]
    @pdf.draw_text "Our Ref: ", at: [340, 648]
    @pdf.draw_text "Date: ", at: [340, 634]
    set_copy_font
    @pdf.draw_text "", at: [400, 662]
    @pdf.draw_text @vessel.reg_no, at: [400, 648]
    @pdf.draw_text Date.today.to_s(:formal), at: [400, 634]
  end

  def correspondent_address
    i = 0
    @correspondent.compacted_address.each do |line|
      @pdf.draw_text line, at: [l_margin, 680 - i]
      i += spacer
    end
  end

  def greeting
    set_copy_font
    @pdf.draw_text "Dear #{@correspondent}", at: [l_margin, 560]
  end

  def vessel_name
    set_bold_font
    @pdf.draw_text @vessel, at: [l_margin, 530]
  end

  def message
    set_copy_font
    i = 0
    message_lines.each do |line|
      @pdf.draw_text line, at: [l_margin, 500 - i]
      i += spacer
    end
  end

  def l_margin
    45
  end

  def spacer
    14
  end

  def set_bold_font
    @pdf.font("Helvetica-Bold", size: 11)
  end

  def set_copy_font
    @pdf.font("Helvetica", size: 11)
  end

  # rubocop:disable Metrics/MethodLength
  def message_lines
    # rubocop:disable Metrics/LineLength
    [
      "I enclose the certificate in respect of the above ship. It should be kept in a safe place on board (except ",
      "when returned for amendment). Please read carefully the important notes that are to be found on the ",
      "certificate. If you think there may be an error on the certificate you must return it to us with a covering ",
      "note. Do not deface or alter the certificate yourself. I would point out that mortgages on a vessel are ",
      "recorded on the main Register but they are not shown on certificates. If you need details of any ",
      "outstanding mortgages you will need to apply to this office for a transcript which costs £21; cheques ",
      "should be crossed and made payable to \"MCA\".",
      "",
      "Please note that engine power is shown in kilowatts, which is approximately 3/4 of the engine ",
      "horsepower.",
      "", "", "Yours sincerely,"
    ]
  end
end
