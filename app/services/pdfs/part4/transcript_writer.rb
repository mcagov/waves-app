class Pdfs::Part4::TranscriptWriter < Pdfs::Extended::TranscriptWriter
  def page_title_for_part
    "OF A BAREBOAT CHARTER SHIP (PART IV)"
  end

  # rubocop:disable all
  def charterer_details_for_part(vertical_offset)
    i = vertical_offset

    @pdf.font("Helvetica", size: 11)
    @pdf.bounding_box([l_margin, 700 - i], width: 510) { @pdf.stroke_horizontal_rule }
    i += 14

    @pdf.draw_text "The following details show the bareboat charter(s):", at: [l_margin, 700 - i]
    i += 10
    @pdf.bounding_box([l_margin, 700 - i], width: 510) { @pdf.stroke_horizontal_rule }
    i += 20
    @pdf.font("Helvetica-Bold", size: 11)
    @pdf.draw_text "Charterer Name & Address", at: [l_margin, 700 - i]
    @pdf.draw_text "Charter Period", at: [420, 700 - i]

    i += 20

    @pdf.font("Helvetica", size: 11)
    @vessel.charterers.sort.each do |charterer|
      @pdf.draw_text charterer.charter_period, at: [420, 700 - i]

      charterer.charter_parties.each do |charter_party|
        @pdf.draw_text charter_party.name, at: [l_margin, 700 - i]
        @pdf.draw_text charter_party.address, at: [l_margin, 700 - i - 15]
        i += 40
      end
    end
  end

  def vessel_details_for_part
    vspace = 22
    vstart = 642
    rcol_l_margin = 300
    draw_label_value "Official Number", @vessel.reg_no, at: [l_margin, vstart]
    draw_label_value "BCS No.", @vessel.reg_no, at: [rcol_l_margin, vstart]
    vstart -= vspace

    draw_label_value "IMO Number/HIN", @vessel.imo_number_or_hin, at: [l_margin, vstart]
    draw_label_value "Radio Call Sign", @vessel.radio_call_sign, at: [rcol_l_margin, vstart]
    vstart -= vspace

    draw_label_value "Name of Ship", @vessel.name, at: [l_margin, vstart]
    vstart -= vspace

    draw_label_value "Port of Choice", WavesUtilities::Port.new(@vessel.port_code).name, at: [l_margin, vstart]
    draw_label_value "Year of Build", @vessel.year_of_build, at: [rcol_l_margin, vstart]
    vstart -= vspace

    draw_label_value "Country of Registration", @vessel.underlying_registry, at: [l_margin, vstart]
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

    @vessel.charterers.each do |charterer|
      draw_label_value "Charterer Start", charterer.start_date, at: [l_margin, vstart]
      draw_label_value "Charterer End", charterer.end_date, at: [rcol_l_margin, vstart]
      vstart -= vspace
    end

    if @registration.closed_at.present?
      draw_label_value "Registration Closed", @registration.closed_at, at: [l_margin, vstart]
    else
      draw_label_value "Certificate of Registry issued", @registration.registered_at, at: [l_margin, vstart]
      draw_label_value "Expires on",  @registration.registered_until, at: [rcol_l_margin, vstart]
    end
  end
  # rubocop:enable all
end