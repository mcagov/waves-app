# rubocop:disable all
class Pdfs::CarvingAndMarking::Over24mUnder500gt < Pdfs::CarvingAndMarking::Base
  private

  def title_text
    "PLEASURE VESSELS OF 24 METRES AND OVER OR MERCHANT SHIPS ON PART I AND PART IV OF THE REGISTER"
  end

  def draw_vessel
    set_copy_font
    @pdf.bounding_box([lmargin, 645], width: 510) { @pdf.stroke_horizontal_rule }
    @pdf.draw_text "VESSEL NAME", at: [lmargin, 625]
    @pdf.draw_text "OFFICIAL NUMBER", at: [lmargin, 600]
    @pdf.draw_text "IMO NUMBER", at: [lmargin, 575]
    @pdf.draw_text "PORT OF CHOICE", at: [lmargin, 550]
    @pdf.draw_text @carving_and_marking_note.tonnage_label, at: [lmargin, 525]

    set_bold_font
    @pdf.draw_text @vessel.name, at: [300, 625]
    @pdf.draw_text @submission.vessel_reg_no, at: [300, 600]
    @pdf.draw_text @vessel.imo_number, at: [300, 575]
    @pdf.draw_text @vessel.port_name, at: [300, 550]
    @pdf.draw_text @carving_and_marking_note.tonnage_value, at: [300, 525]

    @pdf.bounding_box([lmargin, 510], width: 510) { @pdf.stroke_horizontal_rule }
  end

  def draw_certify
    set_copy_font
    @pdf.draw_text "I certify that I have inspected the above-named vessel and it has been *carved and marked/marked",
                  at: [lmargin, 370]
    @pdf.draw_text "(*delete as appropriate) in accordance with the instructions above and overleaf.",
                  at: [lmargin, 355]

    @pdf.draw_text "Signature", at: [lmargin, 320]
    @pdf.bounding_box([100, 315], width: 180) { @pdf.stroke_horizontal_rule }
    @pdf.draw_text "Office Stamp or Inspector's address", at: [300, 320]

    @pdf.draw_text "Name", at: [lmargin, 290]
    @pdf.bounding_box([100, 285], width: 180) { @pdf.stroke_horizontal_rule }

    @pdf.draw_text "Date", at: [lmargin, 260]
    @pdf.bounding_box([100, 255], width: 180) { @pdf.stroke_horizontal_rule }

    @pdf.draw_text "Telephone No", at: [300, 260]
    @pdf.bounding_box([380, 255], width: 120) { @pdf.stroke_horizontal_rule }

    @pdf.draw_text "When this form has been completed, the Inspector of Marks should send or hand this form to the",
                   at: [lmargin, 220]
    @pdf.draw_text "address below, the only exception is if he/she seals the certificate in an envelope, signs across the seal",
                   at: [lmargin, 205]
    @pdf.draw_text "and hands it to the owner or charterer. It can then be sent or handed in, but the seal must be intact.",
                   at: [lmargin, 190]

    @pdf.draw_text "This form must be completed and returned to:", at: [lmargin, 135]
    @pdf.draw_text "UK Ship Register", at: [lmargin, 120]
    @pdf.draw_text "Anchor Court", at: [lmargin, 105]
    @pdf.draw_text "KEEN ROAD", at: [lmargin, 90]
    @pdf.draw_text "Cardiff", at: [lmargin, 75]
    @pdf.draw_text "CF24 5JW", at: [lmargin, 60]
  end

  def draw_marking_notes
    set_copy_font
    @pdf.draw_text "The above vessel is to be marked with the following:", at: [lmargin, 495]
    @pdf.draw_text "- the official number and its appropriate tonnage are to be permanently and conspicuously", at: [lmargin + 20, 480]
    @pdf.draw_text "carved or marked", at: [lmargin + 30, 465]
    @pdf.draw_text "- the name is to be marked on each of its bows and its stern", at: [lmargin + 20, 450]
    @pdf.draw_text "- the port of choice is to be marked on its stern in the manner prescribed over", at: [lmargin + 20, 435]
    @pdf.draw_text "If you are claiming exemption from the usual marking you should tick here [   ] and mark", at: [lmargin, 415]
    @pdf.draw_text "the vessel in accordance with the relevant exemption.", at: [lmargin, 400]
    @pdf.bounding_box([lmargin, 390], width: 510) { @pdf.stroke_horizontal_rule }
  end

  def draw_instructions
     @pdf.font("Helvetica", size: 10)
    vpos = 760
    spacer = 15
    @pdf.draw_text "1. The ship's official number and registered or net tonnage (as appropriate) shall:", at: [lmargin, vpos]
    vpos -= spacer
    @pdf.draw_text "(a) be carved into the beam of the ship", at: [lmargin + 10, vpos]
    vpos -= spacer
    @pdf.draw_text "(b) if there is no main beam, be carved on a readily accesible visible permanent part of", at: [lmargin + 10, vpos]
    vpos -= spacer
    @pdf.draw_text "the structure of the ship either by cutting in, centre-punching or raised lettering or", at: [lmargin + 25, vpos]
    vpos -= spacer
    @pdf.draw_text "(c) be engraved on plates of metal, wood or plastic, secured to the main beam (or if there is", at: [lmargin + 10, vpos]
    vpos -= spacer
    @pdf.draw_text "no main beam, to a readily visible part of the structure) with rivets, through bolts, with", at: [lmargin + 25, vpos]
    vpos -= spacer
    @pdf.draw_text "the ends clenched, or screws with the slots removed.", at: [lmargin + 25, vpos]
    vpos -= spacer
    @pdf.draw_text "", at: [lmargin + 10, vpos]
    vpos -= spacer
    @pdf.draw_text "2. The ship's name shall be permanently marked on each of its bows, and its name and port of choice shall", at: [lmargin, vpos]
    vpos -= spacer
    @pdf.draw_text "be marked on its stern; the marking is to be on a dark ground in white or yellow letters or on a light", at: [lmargin + 10, vpos]
    vpos -= spacer
    @pdf.draw_text "ground in black letters, the letters being not less than 10 centimetres bight and of proportionate breadth.", at: [lmargin + 10, vpos]
    vpos -= spacer
    @pdf.draw_text "The official number and its appropriate tonnage are to be marked as follows:", at: [lmargin + 10, vpos]
    vpos -= spacer
    @pdf.draw_text "", at: [lmargin + 10, vpos]
    vpos -= spacer
    @pdf.font("Helvetica", size: 12)
    @pdf.draw_text "IMO NUMBER   #{@vessel.imo_number}        #{@carving_and_marking_note.tonnage_description}", at: [lmargin + 100, vpos]
    @pdf.font("Helvetica", size: 10)
    vpos -= spacer + 200
    @pdf.draw_text "", at: [lmargin + 10, vpos]
    vpos -= spacer
    @pdf.font("Helvetica-Bold", size: 10)
    @pdf.draw_text "Exemptions", at: [lmargin, vpos]
    @pdf.font("Helvetica", size: 10)
    vpos -= spacer
    @pdf.draw_text "1. Pleasure vessels, pilot vessels, non-seagoing barges and ships employed solely in river", at: [lmargin, vpos]
    vpos -= spacer
    @pdf.draw_text "navigation are exempt from marking the name on the bows.", at: [lmargin + 10, vpos]
    vpos -= spacer
    @pdf.draw_text "2. Pleasure vessels owned by members of exempted yacht clugs are exempt as in 1. and also", at: [lmargin, vpos]
    vpos -= spacer
    @pdf.draw_text "from marking the port of choice on the stern.", at: [lmargin + 10, vpos]
    vpos -= spacer
    @pdf.draw_text "3. Steam and motor pilot vessels are exempt from marking the name on each side of the bows", at: [lmargin, vpos]
    vpos -= spacer
    @pdf.draw_text "and name on the stern.", at: [lmargin + 10, vpos]
    vpos -= spacer
    @pdf.draw_text "4. Lifeboats belonging to R.N.L.I.", at: [lmargin, vpos]
    vpos -= spacer
    @pdf.draw_text "(i) Stell vessels and glass plastic (GRP) vessels are exempt from all marking requirements", at: [lmargin + 10, vpos]
    vpos -= spacer
    @pdf.draw_text "except the name which must be marked on the bows or displayed in a permanent manner", at: [lmargin + 25, vpos]
    vpos -= spacer
    @pdf.draw_text "on each side of the deckhouse.", at: [lmargin + 10, vpos]
    vpos -= spacer
    vpos -= spacer
    @pdf.draw_text "(ii) Other R.N.L.I. vessels are exempt from marking the name and port of choice on the stern.", at: [lmargin + 10, vpos]
  end
end
# rubocop:enable all
