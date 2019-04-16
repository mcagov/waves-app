# rubocop:disable all
class Pdfs::CarvingAndMarking::Over500gt < Pdfs::CarvingAndMarking::Base
  private

  def title_text
    "VESSELS OF 500gt AND OVER ON PART I AND IV OF THE REGISTER"
  end

  def draw_vessel
    set_copy_font
    @pdf.bounding_box([lmargin, 645], width: 510) { @pdf.stroke_horizontal_rule }
    @pdf.draw_text "VESSEL NAME", at: [lmargin, 625]
    @pdf.draw_text "IMO NUMBER", at: [lmargin, 600]
    @pdf.draw_text "PORT OF CHOICE", at: [lmargin, 575]
    @pdf.draw_text @carving_and_marking_note.tonnage_label, at: [lmargin, 550]

    set_bold_font
    @pdf.draw_text @vessel.name, at: [300, 625]
    @pdf.draw_text @vessel.imo_number, at: [300, 600]
    @pdf.draw_text @vessel.port_name, at: [300, 575]
    @pdf.draw_text @carving_and_marking_note.tonnage_value, at: [300, 550]

    @pdf.bounding_box([lmargin, 530], width: 510) { @pdf.stroke_horizontal_rule }
  end

  def draw_marking_notes
    set_copy_font
    @pdf.draw_text "The above vessel is to be marked with the following:", at: [lmargin, 510]
    @pdf.draw_text "- the official number and its appropriate tonnage are to be permanently and conspicuously", at: [lmargin + 20, 495]
    @pdf.draw_text "carved or marked", at: [lmargin + 30, 480]
    @pdf.draw_text "- the name is to be marked on each of its bows and its stern", at: [lmargin + 20, 465]
    @pdf.draw_text "- the port of choice is to be marked on its stern in the manner prescribed overleaf", at: [lmargin + 20, 450]
    @pdf.draw_text "If you are claiming exemption from the usual marking requirements you should tick here [   ] and mark", at: [lmargin, 425]
    @pdf.draw_text "the vessel in accordance with the relevant exemption.", at: [lmargin, 410]
    @pdf.bounding_box([lmargin, 390], width: 510) { @pdf.stroke_horizontal_rule }
  end

  def draw_instructions
    @pdf.font("Helvetica", size: 10)
    vpos = 774
    spacer = 16
    @pdf.draw_text "1. The ship's official/identification number shall be permanently marked as:", at: [lmargin, vpos]
    vpos -= spacer - 2
    @pdf.draw_text "(a) in a visible place either on the stern of the ship or on either side of the hull, amidships port and", at: [lmargin + 10, vpos]
    vpos -= spacer
    @pdf.draw_text "starboard, above the deepest assigned load line or either side of the superstructure, port and", at: [lmargin + 25, vpos]
    vpos -= spacer
    @pdf.draw_text "starboard or on the front of the superstructure or, in the case of passenger ships, on a horizontal", at: [lmargin + 25, vpos]
    vpos -= spacer
    @pdf.draw_text "surface visible from the air and", at: [lmargin + 25, vpos]
    vpos -= spacer
    @pdf.draw_text "(b) in an easily accesible place either on one end of the transverse bulkheads of the machinery", at: [lmargin + 10, vpos]
    vpos -= spacer
    @pdf.draw_text "spaces, as defined in regulation II-2/3.30, or on one of the hatchways or, in the case of tankers,", at: [lmargin + 25, vpos]
    vpos -= spacer
    @pdf.draw_text "in the pump room or, in the case of ships with ro-ro spaces, as defined in regulation II-2/3.41, on", at: [lmargin + 25, vpos]
    vpos -= spacer
    @pdf.draw_text "one of the end transverse bulkheads of the ro-ro spaces.", at: [lmargin + 25, vpos]
    vpos -= spacer
    @pdf.draw_text "The permanent marking shall be plainly visible, clear of any other markings on the hull and shall be", at: [lmargin + 10, vpos]
    vpos -= spacer
    @pdf.draw_text "painted in a contrasting colour.", at: [lmargin + 10, vpos]
    vpos -= spacer
    @pdf.draw_text "The permanent marking referred to in paragraph 1(a) shall be not less than 200mm in height. The", at: [lmargin + 10, vpos]
    vpos -= spacer
    @pdf.draw_text "permanent marking referred to in paragraph 1(b) shall not be less that 100mm in height. The width", at: [lmargin + 10, vpos]
    vpos -= spacer
    @pdf.draw_text "of the marks shall be proportionate to the height.", at: [lmargin + 10, vpos]
    vpos -= spacer
    @pdf.draw_text "The permanent marking may be made by raised lettering or by cutting it in or by centre-punching it or", at: [lmargin + 10, vpos]
    vpos -= spacer
    @pdf.draw_text "by any other equivalent method of marking the ship official/identification number which ensures that", at: [lmargin + 10, vpos]
    vpos -= spacer
    @pdf.draw_text "the marking is easily expunged.", at: [lmargin + 10, vpos]
    vpos -= spacer
    @pdf.draw_text "On ships constructed of material other that steel or metal, the Administration shall approve the", at: [lmargin + 10, vpos]
    vpos -= spacer
    @pdf.draw_text "method of marking the ship identification number.", at: [lmargin + 10, vpos]
    vpos -= spacer
    @pdf.draw_text "", at: [lmargin + 10, vpos]
    vpos -= spacer
    @pdf.draw_text "2. The registered or net tonnage (as appropriate) shall:", at: [lmargin, vpos]
    vpos -= spacer - 2
    @pdf.draw_text "(a) be carved into the main beam of the ship", at: [lmargin + 10, vpos]
    vpos -= spacer
    @pdf.draw_text "(b) if there is no main beam, be carved on a readily accesible visible permanent part of", at: [lmargin + 10, vpos]
    vpos -= spacer
    @pdf.draw_text "the structure of the ship either by cutting in, centre-punching or raised lettering, or", at: [lmargin + 25, vpos]
    vpos -= spacer
    @pdf.draw_text "(c) be engraved on plates of metal, wood or plastic, secured to the main beam (or if there is", at: [lmargin + 10, vpos]
    vpos -= spacer
    @pdf.draw_text "no main beam, to a readily accessible, visible part of the structure) with rivets, through bolts, with", at: [lmargin + 25, vpos]
    vpos -= spacer
    @pdf.draw_text "the ends clenched, or screws with the slots removed.", at: [lmargin + 25, vpos]
    vpos -= spacer
    @pdf.draw_text "", at: [lmargin + 10, vpos]
    vpos -= spacer
    @pdf.draw_text "3. The ship's name shall be permanently marked on each of its bows, and its name and port of choice shall", at: [lmargin, vpos]
    vpos -= spacer
    @pdf.draw_text "be marked on its stern; the marking is to be on a dark ground in white or yellow letters or on a light", at: [lmargin + 10, vpos]
    vpos -= spacer
    @pdf.draw_text "ground in black letters, the letters being not less than 10 centimetres high and of proportionate breadth.", at: [lmargin + 10, vpos]
    vpos -= spacer
    vpos -= spacer
    @pdf.draw_text "The official number and its appropriate tonnage are to be marked as follows:", at: [lmargin + 10, vpos]
    vpos -= spacer
    @pdf.draw_text "", at: [lmargin, vpos]
    vpos -= spacer - 4
    @pdf.font("Helvetica", size: 12)
    @pdf.draw_text "IMO NUMBER   #{@vessel.imo_number}        #{@carving_and_marking_note.tonnage_description}", at: [lmargin + 100, vpos]
    @pdf.font("Helvetica", size: 10)
    vpos -= spacer + 10
    @pdf.font("Helvetica-Bold", size: 10)
    @pdf.draw_text "Exemptions", at: [lmargin, vpos]
    @pdf.font("Helvetica", size: 10)
    vpos -= spacer
    @pdf.draw_text "1. Pleasure vessels, pilot vessels, non-seagoing barges and ships employed solely in river", at: [lmargin, vpos]
    vpos -= spacer
    @pdf.draw_text "navigation are exempt from marking the name on each of the bows.", at: [lmargin + 10, vpos]
    vpos -= spacer
    @pdf.draw_text "2. Pleasure vessels owned by members of exempted yacht clubs are exempt as in 1. and also", at: [lmargin, vpos]
    vpos -= spacer
    @pdf.draw_text "from marking the port of choice on the stern.", at: [lmargin + 10, vpos]
    vpos -= spacer
    @pdf.draw_text "3. Steam and motor pilot vessels are exempt from marking the name on each side of the bows", at: [lmargin, vpos]
    vpos -= spacer
    @pdf.draw_text "and name on the stern.", at: [lmargin + 10, vpos]
    vpos -= spacer
    @pdf.draw_text "4. Lifeboats belonging to R.N.L.I.", at: [lmargin, vpos]
    vpos -= spacer
    @pdf.draw_text "(i) Steel vessels and glass plastic (GRP) vessels are exempt from all marking requirements", at: [lmargin + 10, vpos]
    vpos -= spacer
    @pdf.draw_text "except the name which must be marked on the bows or displayed in a permanent manner", at: [lmargin + 25, vpos]
    vpos -= spacer
    @pdf.draw_text "on each side of the deckhouse.", at: [lmargin + 10, vpos]
    vpos -= spacer
    @pdf.draw_text "(ii) Other R.N.L.I. vessels are exempt from marking the name and port of choice on the stern.", at: [lmargin + 10, vpos]
  end
end
# rubocop:enable all
