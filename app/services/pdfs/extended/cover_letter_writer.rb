# rubocop:disable all
class Pdfs::Extended::CoverLetterWriter < Pdfs::CoverLetterWriter
  def write
    @pdf.start_new_page
    init_stationary
    vessel_name
    message
    fishing_notes if Policies::Definitions.fishing_vessel?(@vessel)
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

  def fishing_notes
    vpos = 790
    spacer = 14
    dblspacer = spacer*2
    trplspacer = spacer*3
    col2 = 100
    @pdf.start_new_page
    set_headline_font
    @pdf.draw_text "Mandatory and Voluntary Training for the Crew of Fishing Vessels", at: [l_margin, vpos]
    vpos -= dblspacer
    set_bold_font
    @pdf.draw_text "MANDATORY SAFETY TRAINING REQUIREMENTS ON ALL FISHING VESSELS", at: [l_margin, vpos]

    vpos -= dblspacer
    @pdf.font("Helvetica-Bold", size: 10)
    @pdf.draw_text "1.0", at: [l_margin, vpos]
    @pdf.draw_text "New Entrants", at: [col2, vpos]
    vpos -= spacer
    @pdf.font("Helvetica", size: 9)
    @pdf.draw_text "1.1", at: [l_margin, vpos]
    text = "A new entrant is defined as a person who is for the first time gainfully employed or engaged as a crew member on a commercial fishing vessel registered in the United Kingdom."
    @pdf.text_box text, at: [col2, vpos + 6], width: 400

    vpos -= dblspacer
    @pdf.font("Helvetica", size: 9)
    @pdf.draw_text "1.2", at: [l_margin, vpos]
    text = "All new entrants must before starting work as a fisherman have completed the following:"
    @pdf.text_box text, at: [col2, vpos + 6], width: 400
    vpos -= spacer
    text = "- 1 day Basic Sea Survival."
    @pdf.text_box text, at: [col2, vpos + 6], width: 400

    vpos -= spacer
    @pdf.font("Helvetica", size: 9)
    @pdf.draw_text "1.3", at: [l_margin, vpos]
    text = "Within 3 months of starting work, all new entrant fishermen must complete the following additional courses:"
    @pdf.text_box text, at: [col2, vpos + 6], width: 400
    vpos -= dblspacer
    text = "- 1 day Basic Fire Fighting and Prevention;"
    @pdf.text_box text, at: [col2, vpos + 6], width: 400
    vpos -= spacer
    text = "- 1 day Basic First Aid; and"
    @pdf.text_box text, at: [col2, vpos + 6], width: 400
    vpos -= spacer
    text = "- 1 day Basic Health and Safety (only required of new entrants since 01 January 2005)."
    @pdf.text_box text, at: [col2, vpos + 6], width: 400

    vpos -= dblspacer
    @pdf.font("Helvetica-Bold", size: 10)
    @pdf.draw_text "2.0", at: [l_margin, vpos]
    @pdf.draw_text "Experienced Fishermen", at: [col2, vpos]
    vpos -= spacer
    @pdf.font("Helvetica", size: 9)
    @pdf.draw_text "2.1", at: [l_margin, vpos]
    text = "An experienced fisherman is defined as a fisherman who has been working as a fisherman for two years or more."
    @pdf.text_box text, at: [col2, vpos + 6], width: 400

    vpos -= dblspacer
    @pdf.font("Helvetica", size: 9)
    @pdf.draw_text "2.2", at: [l_margin, vpos]
    text = "In addition to the courses required of new entrants (above), all experienced fishermen, regardless of whether they hold a Certificate of Competency or not, must complete the following course:"
    @pdf.text_box text, at: [col2, vpos + 6], width: 400
    vpos -= dblspacer
    text = "- 1 day Safety Awareness and Risk Assessment."
    @pdf.text_box text, at: [col2, vpos + 6], width: 400

    vpos -= spacer
    @pdf.font("Helvetica", size: 9)
    @pdf.draw_text "2.3", at: [l_margin, vpos]
    text = "Upon completion of this course, experienced fishermen are recommended to apply to Seafish for an experienced fisherman photo ID card verifying their compliance with this requirement."
    @pdf.text_box text, at: [col2, vpos + 6], width: 400

    vpos -= trplspacer
    @pdf.font("Helvetica-Bold", size: 10)
    @pdf.draw_text "3.0", at: [l_margin, vpos]
    @pdf.draw_text "Additional Voluntary Training Courses", at: [col2, vpos]

    vpos -= spacer
    @pdf.font("Helvetica", size: 9)
    @pdf.draw_text "3.1", at: [l_margin, vpos]
    text = "In addition to the mandatory courses, the following voluntary courses are available:"
    @pdf.text_box text, at: [col2, vpos + 6], width: 400
    vpos -= spacer
    text = "- Bridge Watchkeeping 2 day course (intended for skippers of vessels less than 16.5m operating within 20 miles from a safe haven)"
    @pdf.text_box text, at: [col2, vpos + 6], width: 400
    vpos -= dblspacer
    text = "- Bridge Watchkeeping 5 day course (intended for anyone taking a navigational watch and skippers of vessels less than 16.5m operating beyond 20 miles from a safe haven) "
    @pdf.text_box text, at: [col2, vpos + 6], width: 400
    vpos -= dblspacer
    text = "- Diesel Engine 1 day course (intended for skippers of vessels less than 16.5m operating within 20 miles from a safe haven)"
    @pdf.text_box text, at: [col2, vpos + 6], width: 400
    vpos -= dblspacer
    text = "- Engine Room Watchkeeping 2 day course (intended for skippers of vessels less than 16.5m operating beyond 20 miles from a safe haven)"
    @pdf.text_box text, at: [col2, vpos + 6], width: 400
    vpos -= dblspacer
    text = "- Engine Room Watchkeeping 5 day course (intended for anyone taking an engine room watch)"
    @pdf.text_box text, at: [col2, vpos + 6], width: 400
    vpos -= spacer
    text = "- Intermediate Stability Awareness 1 day course (intended for skippers of vessels less than 16.5m)"
    @pdf.text_box text, at: [col2, vpos + 6], width: 400

    vpos -= dblspacer
    @pdf.draw_text "3.2", at: [l_margin, vpos]
    text = "It is our intention to consult with the fishing industry as to whether these courses should become mandatory for all skippers of vessels of less than 16.5m registered length."
    @pdf.text_box text, at: [col2, vpos + 7], width: 400

    vpos -= dblspacer
    @pdf.draw_text "3.3", at: [l_margin, vpos]
    text = "Fishermen who complete the Bridge Watchkeeping 2 day course, the Diesel Engine 1 day course and the Stability Awareness Course satisfactorily will receive a Skippers Certificate for Under 16.5m Vessels up to 20 miles."
    @pdf.text_box text, at: [col2, vpos + 7], width: 400

    vpos -= trplspacer
    @pdf.draw_text "3.4", at: [l_margin, vpos]
    text = "Fishermen who complete the Bridge Watchkeeping 5 day course, 2 day Engine course and the Stability Awareness Course satisfactorily will receive a Skippers Certificate for Under 16.5m Vessels operating beyond 20 miles."
    @pdf.text_box text, at: [col2, vpos + 7], width: 400

    vpos -= trplspacer
    @pdf.font("Helvetica-Bold", size: 10)
    @pdf.draw_text "4.0", at: [l_margin, vpos]
    @pdf.draw_text "Acceptance of Under 16.5m Skippers Certificates for Code Vessel Operations", at: [col2, vpos]

    vpos -= spacer
    @pdf.font("Helvetica", size: 9)
    @pdf.draw_text "4.1", at: [l_margin, vpos]
    text = "The Under 16.5m Skippers Certificates are recognised by MCA for use on Code Vessels as follows:"
    @pdf.text_box text, at: [col2, vpos + 6], width: 400
    vpos -= spacer
    text = "- Under 16.5m Skippers Certificate  (beyond 20 miles) may be used on Code vessels operating up to Area Category 3 (up to 20 miles from a safe haven)"
    @pdf.text_box text, at: [col2, vpos + 6], width: 400
    vpos -= dblspacer
    text = "- Under 16.5m Skippers Certificate  (up to 20 miles) may be used on Code vessels operating up to Area Category 6 (up to 3 miles from a nominated departure point named in the vessels certificate and never more than 3 miles from land, in favourable weather and daylight."
    @pdf.text_box text, at: [col2, vpos + 6], width: 400
  end
end
# rubocop:enable all
