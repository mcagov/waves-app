class Pdfs::MortgageeReminderLetterWriter
  include Pdfs::Stationary

  def initialize(mortagee, pdf)
    @mortgagee = mortagee
    @mortgage = mortagee.parent
    @vessel = @mortgagee.vessel
    @registration = @vessel.try(:current_registration)
    @delivery_name_and_address =
      @mortgagee.compacted_address.unshift(@mortgagee.name)
    @applicant_name = @mortgagee.name
    @pdf = pdf
  end

  def write
    @pdf.start_new_page
    init_stationary(@registration.updated_at)
    vessel_name
    message
    @pdf
  end

  protected

  def vessel_name
    set_bold_font
    @pdf.draw_text @vessel[:name], at: [l_margin, 530]
  end

  # rubocop:disable all
  def message
    msg = "I am writing to inform you that the registration of the above ship"
    msg += " is due to expire on #{@registration.registered_until}. It appears"
    msg += " from our records that the following mortgage is outstanding:"

    set_copy_font
    @pdf.text_box msg, at: [l_margin, 505], width: 480, height: 100, leading: 8

    @pdf.draw_text @mortgagee.name, at: [l_margin, 450]
    @pdf.text_box @mortgagee.inline_address, width: 400, height: 30, at: [l_margin, 445]

    @pdf.draw_text "Date mortgage executed: ", at: [l_margin, 410]
    @pdf.draw_text @mortgage.executed_at, at: [200, 410]

    @pdf.draw_text "Date registered: ", at: [l_margin, 390]
    @pdf.draw_text @mortgage.registered_at, at: [200, 390]

    @pdf.draw_text "No. of shares mortgaged: ", at: [l_margin, 370]
    @pdf.draw_text @mortgage.amount, at: [200, 370]

    @pdf.draw_text "Mortgage Priority: ", at: [l_margin, 350]
    @pdf.draw_text @mortgage.priority_code, at: [200, 350]

    msg = "In accordance with Regulation 63 of the Merchant Shipping"
    msg += " (Registration of Ships) Regulations 1993, we will transfer"
    msg += " your outstanding mortgage to the clised Register if the owner"
    msg += " fails to renew the Certificate of Registry. It will remain"
    msg += " recorded until you notify us that it has been discharged. I"
    msg += " would point out that this process will not affect the validity"
    msg += " of this mortgage."

    set_copy_font
    @pdf.text_box msg, at: [l_margin, 320], width: 480, height: 100, leading: 8

    @pdf.draw_text "Yours sincerely,", at: [l_margin, 210]
    @pdf.draw_text "Registration Officer", at: [l_margin, 150]
  end
  # rubocop:enable all
end
