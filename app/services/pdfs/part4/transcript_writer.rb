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
  # rubocop:enable all
end
