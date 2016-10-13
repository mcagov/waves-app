class CoverLetterWriter
  include Stationary

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
