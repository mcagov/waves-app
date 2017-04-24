class Pdfs::Part1::TranscriptWriter < Pdfs::Extended::TranscriptWriter
  private

  def page_title_for_part
    "OF A BRITISH SHIP"
  end

  # rubocop:disable all
  def vessel_details_for_part
    vspace = 24
    vstart = 642
    rcol_l_margin = 300
    draw_label_value "Official Number", @vessel.reg_no, at: [l_margin, vstart]
    draw_label_value "EC Number", EcNo.for_vessel(@vessel), at: [rcol_l_margin, vstart]
    vstart -= vspace

    draw_label_value "IMO Number/HIN", @vessel.imo_number_or_hin, at: [l_margin, vstart]
    draw_label_value "Radio Call Sign", @vessel.radio_call_sign, at: [rcol_l_margin, vstart]
    vstart -= vspace

    draw_label_value "Name of Vessel", @vessel.name, at: [l_margin, vstart]
    vstart -= vspace

    draw_label_value "Year of Build", @vessel.year_of_build, at: [l_margin, vstart]
    vstart -= vspace

    draw_label_value "Method of Propulsion", @vessel.formatted_propulsion_system, at: [l_margin, vstart]
    vstart -= vspace

    draw_label_value "Where Built", @vessel.place_of_build, at: [l_margin, vstart]
    draw_label_value "Construction Material", @vessel.hull_construction_material, at: [rcol_l_margin, vstart]
    vstart -= vspace

    draw_label_value "Name of Builder", @vessel.name_of_builder, at: [l_margin, vstart]
    vstart -= vspace
    draw_value @vessel.builders_address, at: [l_margin + 145, vstart]
    vstart -= vspace

    @vessel.engines.each do |engine|
      draw_label_value "Engine Make & Model", engine.make_and_model, at: [l_margin, vstart]
      if engine.derating.present?
        vstart -= vspace/2
        draw_label_value "Derating", engine.derating, at: [l_margin, vstart]
      end
      vstart -= vspace
    end

    draw_label_value "Total Engine Power", "#{Engine.total_mcep_for(@registration)} kW", at: [l_margin, vstart]
    vstart -= vspace

    draw_label_value "Overall Length", "#{@vessel.length_overall} metres", at: [l_margin, vstart]
    draw_label_value "Registered Length", "#{@vessel.register_length} metres", at: [rcol_l_margin, vstart]
    vstart -= vspace

    draw_label_value "Breadth", "#{@vessel.breadth} metres", at: [l_margin, vstart]
    draw_label_value "Depth", "#{@vessel.depth} metres", at: [rcol_l_margin, vstart]
    vstart -= vspace
    draw_label_value "Gross Tonnage", @vessel.gross_tonnage, at: [l_margin, vstart]
    draw_label_value "Net Tonnage", @vessel.net_tonnage, at: [rcol_l_margin, vstart]
    vstart -= vspace

    draw_label_value "Registered Tonnage", @vessel.register_tonnage, at: [l_margin, vstart]
    vstart -= vspace

    if @registration.closed_at.present?
      draw_label_value "Registration Closed", @registration.closed_at, at: [l_margin, vstart]
    else
      draw_label_value "Certificate of Registry issued", @registration.registered_at, at: [l_margin, vstart]
      draw_label_value "Expires on",  @registration.registered_until, at: [rcol_l_margin, vstart]
    end
  end
  # rubocop:enable all
end
