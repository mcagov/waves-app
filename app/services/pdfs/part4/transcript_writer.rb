class Pdfs::Part4::TranscriptWriter < Pdfs::Extended::TranscriptWriter
  def page_title_for_part
    "OF A BAREBOAT CHARTER SHIP (PART IV)"
  end

  # rubocop:disable all
   def owner_details_for_part
    y_pos = 700

    owner = @owners.first
    if owner
      default_value_font
      @pdf.draw_text "Primary Owner:", at: [l_margin, y_pos]
      y_pos -= 20
      default_label_font
      @pdf.draw_text owner.name, at: [l_margin, y_pos]
      @pdf.text_box owner.inline_address, width: 400, height: 30, at: [l_margin, y_pos - 5]
      y_pos -= 20
    end
    y_pos -= 40
    default_value_font
    @pdf.draw_text "The following details show the bareboat charter(s):", at: [l_margin, y_pos]
    y_pos -= 20
    @pdf.draw_text "Charterer:", at: [l_margin, y_pos]
    @pdf.draw_text "Charter Period", at: [420, y_pos]
    default_label_font
    y_pos -= 20

    @vessel.charterers.sort.each do |charterer|
      @pdf.draw_text charterer.charter_period, at: [420, y_pos]

      charterer.charter_parties.each do |charter_party|
        @pdf.draw_text charter_party.name, at: [l_margin, y_pos]
        @pdf.draw_text charter_party.inline_address, at: [l_margin, y_pos - 15]
        y_pos -= 40
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

    draw_label_value "Name on Primary Register", @vessel.name_on_primary_register, at: [l_margin, vstart]
    vstart -= vspace + 15

    draw_label_value "Method of Propulsion", @vessel.propulsion_system, at: [l_margin, vstart]
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

    draw_label_value "Gross Tonnage", Tonnage.new(:gross, @vessel.gross_tonnage), at: [l_margin, vstart]
    draw_label_value "Net Tonnage", Tonnage.new(:net, @vessel.net_tonnage), at: [rcol_l_margin, vstart]
    vstart -= vspace

    draw_label_value "Registered Tonnage", Tonnage.new(:register, @vessel.register_tonnage), at: [l_margin, vstart]
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
