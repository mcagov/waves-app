class Pdfs::Part2::CertificateWriter < Pdfs::CertificateWriter
  private

  def write_attachable
    @pdf.start_new_page
    @pdf.image page_1_template, scale: 0.4796
    watermark
    vessel_details
    registration_details
    @pdf.start_new_page
    @pdf.image page_2_template, scale: 0.4796
    owner_details
    watermark
  end

  def write_printable
    @pdf.start_new_page
    vessel_details
    registration_details
    @pdf.start_new_page
    owner_details
  end

  def page_1_template
    "#{Rails.root}/public/pdf_images/part_2_front.png"
  end

  def page_2_template
    "#{Rails.root}/public/pdf_images/part_2_rear.png"
  end

  # rubocop:disable all
  def vessel_details
    vspace = 26
    vstart = 642
    rcol_lmargin = 350
    draw_label_value "Name of Ship", @vessel.name, at: [lmargin, vstart]
    vstart -= vspace
    draw_label_value "Official Number", @vessel.reg_no, at: [lmargin, vstart]
    draw_label_value "Radio Call Sign", @vessel.radio_call_sign, at: [rcol_lmargin, vstart]
    vstart -= vspace
    draw_label_value "IMO Number", @vessel.imo_number, at: [lmargin, vstart]
    draw_label_value "Port", WavesUtilities::Port.new(@vessel.port_code).name, at: [rcol_lmargin, vstart]
    vstart -= vspace
    draw_label_value "Type of Ship", @vessel.vessel_type, at: [lmargin, vstart]
    draw_label_value "Port Letters and Number", "#{@vessel.port_code} #{@vessel.port_no}", at: [rcol_lmargin, vstart]

    engine_label = "Engine Make/Model"
    @engines.each do |engine|
      vstart -= vspace
      draw_label_value engine_label, engine.make_and_model, at: [lmargin, vstart]
      engine_label = ""

      derating_label = "Derating"
      draw_label_value derating_label, engine.derating, at: [rcol_lmargin, vstart]
      derating_label = ""
    end

    vstart -= vspace
    draw_label_value "Total Engine Power", "#{Engine.total_mcep_for(@registration)} kW", at: [lmargin, vstart]
    vstart -= vspace
    draw_label_value "Overall Length", "#{@vessel.length_overall} metres", at: [lmargin, vstart]
    draw_label_value "Registered Length", "#{@vessel.register_length} metres", at: [rcol_lmargin, vstart]
    vstart -= vspace
    draw_label_value "Breadth", "#{@vessel.breadth} metres", at: [lmargin, vstart]
    draw_label_value "Depth", "#{@vessel.depth} metres", at: [rcol_lmargin, vstart]
    vstart -= vspace
    draw_label_value "Gross Tonnage", @vessel.gross_tonnage, at: [lmargin, vstart]
    draw_label_value "Net Tonnage", @vessel.net_tonnage, at: [rcol_lmargin, vstart]
    vstart -= vspace
    draw_label_value "Year of Build", @vessel.year_of_build, at: [lmargin, vstart]
    vstart -= vspace
    draw_label_value "Place of Build", @vessel.place_of_build, at: [lmargin, vstart]
    vstart -= vspace
    draw_label_value "Country of Build", @vessel.country_of_build, at: [lmargin, vstart]
    vstart -= vspace
    draw_label_value "Date of Entry into Service", @vessel.entry_into_service_at, at: [lmargin, vstart]
    vstart -= vspace
    draw_label_value "Type of Registration", @vessel.registration_type.try(:titleize), at: [lmargin, vstart]
  end

  def registration_details
    default_label_font
    @pdf.text_box("This Certificate was issued on:", at: [lmargin, 220], width: 220)
    @pdf.text_box("This Certificate expires on:", at: [lmargin, 190])
    default_value_font
    @pdf.draw_text(@registration.registered_at.to_s(:date_time), at: [240, 213])
    @pdf.draw_text(@registration.registered_until.to_s(:date_summary), at: [240, 183])
  end

  def owner_details
    y_pos = 730
    @owners.each do |owner|
      draw_label owner.name, at: [lmargin, y_pos]
      draw_label owner.inline_address, at: [lmargin, y_pos - 15]
      draw_label owner.shares_held, at: [474, y_pos]
      y_pos -= 40
    end

    @registration.shareholder_groups.each do |shareholder_group|
      draw_label shareholder_group[:shareholder_names].join(", "), at: [lmargin, y_pos]
      draw_label shareholder_group[:shares_held], at: [474, y_pos]
      y_pos -= 25
    end
  end
  # rubocop:enable all

  def draw_label_value(label, text, opts)
    default_label_font
    @pdf.text_box("#{label}:", opts.merge(width: 140)) if label.present?
    default_value_font
    @pdf.draw_text(text, at: [opts[:at][0] + 140, opts[:at][1] - 7])
  end

  def draw_value(text, opts = {})
    default_value_font
    @pdf.draw_text(text, opts)
  end

  def draw_label(text, opts = {})
    default_label_font
    @pdf.draw_text(text, opts)
  end

  def lmargin
    40
  end

  def watermark
    @pdf.transparent(0.1) do
      @pdf.draw_text "COPY OF ORIGINAL", at: [60, 10], rotate: 60, size: 94
    end
  end
end
