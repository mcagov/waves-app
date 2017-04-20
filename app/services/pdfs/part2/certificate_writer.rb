class Pdfs::Part2::CertificateWriter < Pdfs::Extended::CertificateWriter
  private

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
    draw_label_value "Type of Ship", @vessel.vessel_type_description, at: [lmargin, vstart]
    draw_label_value "Port Letters and Number", "#{@vessel.port_code} #{@vessel.port_no}", at: [rcol_lmargin, vstart]

    engine_label = "Engine Make/Model"
    @engines.each do |engine|
      vstart -= vspace
      draw_label_value engine_label, engine.make_and_model, at: [lmargin, vstart]
      engine_label = ""
      vstart -= vspace
      derating_label = "Derating"
      draw_label_value derating_label, engine.derating, at: [lmargin, vstart]
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
  # rubocop:enable all
end
