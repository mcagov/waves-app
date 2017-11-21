class Pdfs::ForcedClosureWriter
  include Pdfs::Stationary

  def initialize(registration, pdf)
    @registration = registration
    @vessel = @registration.vessel
    @applicant_name = @registration.applicant_name
    @delivery_name_and_address = @registration.delivery_name_and_address
    @pdf = pdf
  end

  def write
    @pdf.start_new_page
    init_stationary(@registration.created_at)
    vessel_name
    message
    @pdf.start_new_page
    registration_number
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

  def registration_number
    @pdf.font("Times-Roman", size: 124)
    @pdf.draw_text @vessel[:reg_no], at: [300, 100], rotate: 90
  end

  # rubocop:disable all
  def message_text
    [
      "Yours sincerely,",
      "\n\n\n\n",
      @registration.actioned_by.to_s,
      "\n",
      "Registration Officer"
    ].map { |line| { text: line } }
  end
  # rubocop:enable all
end
