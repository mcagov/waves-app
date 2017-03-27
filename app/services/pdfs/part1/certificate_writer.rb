class Pdfs::Part1::CertificateWriter < Pdfs::Extended::CertificateWriter
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
    draw_label_value "IMO Number/HIN", @vessel.imo_number, at: [lmargin, vstart]
    draw_label_value "Port", WavesUtilities::Port.new(@vessel.port_code).name, at: [rcol_lmargin, vstart]
    vstart -= vspace
    draw_label_value "Type of Ship", @vessel.vessel_type, at: [lmargin, vstart]
    vstart -= vspace
    draw_label_value "Method of Propulsion", @vessel.formatted_propulsion_system, at: [lmargin, vstart]

    engine_label = "Engine Make/Model"
    @engines.each do |engine|
      vstart -= vspace
      draw_label_value engine_label, engine.make_and_model, at: [lmargin, vstart]
      engine_label = ""
    end

    vstart -= vspace
    draw_label_value "Total Engine Power", "#{Engine.total_mcep_for(@registration)} kW", at: [lmargin, vstart]
    vstart -= vspace
    draw_label_value "Length", "#{@vessel.length_overall} metres", at: [lmargin, vstart]
    vstart -= vspace
    draw_label_value "Depth", "#{@vessel.depth} metres", at: [lmargin, vstart]
    draw_label_value "Breadth", "#{@vessel.breadth} metres", at: [rcol_lmargin, vstart]
    vstart -= vspace
    draw_label_value "Gross Tonnage", @vessel.gross_tonnage, at: [lmargin, vstart]
    draw_label_value "Net Tonnage", @vessel.net_tonnage, at: [rcol_lmargin, vstart]
    vstart -= vspace
    draw_label_value "Registered Tonnage", @vessel.register_tonnage, at: [lmargin, vstart]
    vstart -= vspace
    draw_label_value "Year of Build", @vessel.year_of_build, at: [lmargin, vstart]
    vstart -= vspace
    draw_label_value "Name of Builder", @vessel.name_of_builder, at: [lmargin, vstart]
    vstart -= vspace
    draw_label_value "Country of Build", @vessel.country_of_build, at: [lmargin, vstart]
  end
  # rubocop:enable all
end
