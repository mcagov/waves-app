class Pdfs::CoverLetterWriter
  include Pdfs::Stationary

  def initialize(registration, pdf)
    @registration = registration
    @vessel = @registration.vessel
    @correspondent = @registration.owners.first
    @pdf = pdf
  end

  def write
    @pdf.start_new_page
    init_stationary
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
      "Your new Certificate of Registry is enclosed.  As the certificate is valid throughout the world it is important that you check all the details are correct to ensure you do not have any problems entering a foreign port.  Should any of the details be incorrect please return it for amendment immediately.",
      "\n\n",
      "You must ensure that your vessel is marked with its registered number (including the prefix \"SSR\").  This must be painted on, or fixed to the exterior of the hull, deck or superstructure where it can be readily seen.",
      "\n\n",
      "Each digit of the number should be a minimum of 30mm in height and 20mm in width, except for the number 1, which should be 5 mm in width and have a thickness of 5mm with a space of 5mm between each digit.",
      "\n\n",
      "Any plate or raised lettering used to display the number must be securely attached to the vessel and should be effectively maintained and renewed where necessary.",
      "\n\n",
      "The Hull Identification Number (HIN), has recently been introduced on newly constructed vessels , will only be shown on the Certificate of British Registry when the number has been submitted on the application form.  HIN's are fixed to the hull by the boat builder and can normally be found on the starboard outboard side of the transom or hull.",
      "\n\n",
      "Please note that you must return your Certificate of British Registry to this office if there are any changes to the ownership or other registration particulars of your vessel.  The fee for re-registration, taking any changes into account, is £25.00.",
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
