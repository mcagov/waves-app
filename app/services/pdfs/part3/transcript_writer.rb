class Pdfs::Part3::TranscriptWriter < Pdfs::TranscriptWriter
  private

  def page_title_for_part
    "OF A UK SHIP"
  end

  def owner_details_for_part
    i = 0
    @owners.each do |owner|
      @pdf.font("Helvetica", size: 12)
      @pdf.draw_text owner.name, at: [l_margin, 700 - i]
      @pdf.text_box owner.inline_address, width: 500, at: [l_margin, 690 - i]
      i += 60
    end
  end

  # rubocop:disable all
  def vessel_details_for_part
    draw_label_value "SSR NUMBER", @vessel.reg_no, at: [l_margin, 620]
    draw_label_value "NAME OF SHIP", @vessel.name, at: [l_margin, 590]
    draw_label_value "DESCRIPTION", @vessel.vessel_type, at: [l_margin, 560]
    draw_label_value "OVERALL LENGTH",
                     "#{@vessel.length_in_meters} metres",
                     at: [l_margin, 530]
    draw_label_value "NUMBER OF HULLS",
                     @vessel.number_of_hulls, at: [l_margin, 500]
    draw_label_value "H. I. NUMBER", @vessel.hin, at: [l_margin, 470]

    @pdf.font("Helvetica", size: 16)
    @pdf.draw_text "REGISTRATION DETAILS", at: [l_margin, 400]

    draw_label_value "DATE OF LAST CERTIFICATE",
                     @registration.registered_at, at: [l_margin, 380]
    draw_label_value "DATE OF EXPIRY",
                     @registration.registered_until, at: [l_margin, 360]

    if @registration.closed_at
      draw_label_value "REGISTRATION CLOSED",
                       @registration.closed_at, at: [l_margin, 340]
    end
  end

  def certification_text
    s = "I certify that this transcript consisting of two pages is a true"
    s += " extract from part III of the Register (Small Ships Register)"
    s += " now in my charge showing the descriptive particulars and"
    s += " registered ownership/s as at"

    [
      { text: s },
      { text: @registration.created_at.to_s, styles: [:bold] },
      { text: "." }
    ]
  end

  def draw_page_2
    @pdf.start_new_page
    @pdf.font("Helvetica", size: 11)

    @pdf.move_down 60
    @pdf.stroke_horizontal_rule

    @pdf.draw_text "The following details show the current ownership of ",
                   at: [l_margin, 760]
    @pdf.draw_text "#{@vessel.name} #{@vessel.reg_no}",
                   at: [l_margin, 746]

    @pdf.move_down 50

    @pdf.stroke_horizontal_rule

    owner_details_for_part

    @pdf.text_box "Page 2 of 2", width: 500,
        at: [262, 40]
  end
  # rubocop:enable all

  def draw_label_value(label, text, opts)
    default_label_font
    @pdf.text_box("#{label} :", opts.merge(width: 200))
    default_value_font
    @pdf.draw_text(text, at: [opts[:at][0] + 185, opts[:at][1] - 7])
  end

  def draw_value(text, opts = {})
    default_value_font
    @pdf.draw_text(text, opts)
  end

  def default_value_font
    @pdf.font("Helvetica-Bold", size: 12)
  end

  def default_label_font
    @pdf.font("Helvetica", size: 12)
  end

  def l_margin
    44
  end
end
