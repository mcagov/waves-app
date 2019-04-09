# rubocop:disable all
class Pdfs::CarvingAndMarking::AllFishing < Pdfs::CarvingAndMarking::Base
  private

  def title_text
    "FISHING VESSELS ON PART II & IV OF THE REGISTER"
  end

  def draw_vessel
    set_copy_font
    @pdf.bounding_box([lmargin, 645], width: 510) { @pdf.stroke_horizontal_rule }
    @pdf.draw_text "VESSEL NAME", at: [lmargin, 625]
    @pdf.draw_text "OFFICIAL NUMBER", at: [lmargin, 590]
    @pdf.draw_text "PORT OF CHOICE", at: [lmargin, 555]
    @pdf.draw_text "PORT LETTERS AND NUMBERS", at: [lmargin, 535]

    set_bold_font
    @pdf.draw_text @vessel.name, at: [300, 625]
    @pdf.draw_text @submission.vessel_reg_no, at: [300, 590]
    @pdf.draw_text @vessel.port_name, at: [300, 555]
    @pdf.draw_text @vessel.pln, at: [300, 535]

    @pdf.bounding_box([lmargin, 520], width: 510) { @pdf.stroke_horizontal_rule }
  end

  def draw_marking_notes
    set_copy_font
    @pdf.draw_text "The above vessel is to be marked with the following:", at: [lmargin, 500]
    @pdf.draw_text "- the official number to be conspicuously carved in the appropriate way", at: [lmargin + 20, 485]
    @pdf.draw_text "- the name and port of choice to be marked on the stern", at: [lmargin + 20, 470]
    @pdf.draw_text "- the port letters and numbers to be marked on both sides of the bow, on each quarter", at: [lmargin + 20, 455]
    @pdf.draw_text "and also on the wheel house top or some other prominent horizontal surface", at: [lmargin + 30, 440]
    @pdf.draw_text "in the manner prescribed overleaf", at: [lmargin + 30, 425]
    @pdf.draw_text "When this has been done, you must contact an Inspector of Marks who will certify that the", at: [lmargin, 400]
    @pdf.draw_text "carving and marking are correct. Please ensure you give the Inspector at least 30 days’ notice.", at: [lmargin, 385]
    @pdf.bounding_box([lmargin, 375], width: 510) { @pdf.stroke_horizontal_rule }
  end

  def draw_instructions
    set_copy_font
    vpos = 760
    spacer = 20
    @pdf.draw_text "1. The vessel's official number must:", at: [lmargin, vpos]
    vpos -= spacer
    @pdf.draw_text "(a) be carved into the main beam of the vessel, or", at: [lmargin + 10, vpos]
    vpos -= spacer
    @pdf.draw_text "(b) if there is no beam, be carved on a readily accessible visible permanent part of the", at: [lmargin + 10, vpos]
    vpos -= spacer
    @pdf.draw_text "structure of the ship either by cutting in, centre punching or raised lettering, or", at: [lmargin + 25, vpos]
    vpos -= spacer
    @pdf.draw_text "(c) be engraved on plates of metal, wood or plastic secured to the main beam (or if there is", at: [lmargin + 10, vpos]
    vpos -= spacer
    @pdf.draw_text "no main beam, to a readily accessible visible part of the structure) with rivets, through botls", at: [lmargin + 25, vpos]
    vpos -= spacer
    @pdf.draw_text "with the ends clenched, or screws with the slots removed.", at: [lmargin + 25, vpos]
    vpos -= spacer + 10
    @pdf.draw_text "NB Where a fishing vessel was previously registered under Part I of the Merchant Shipping", at: [lmargin + 10, vpos]
    vpos -= spacer
    @pdf.draw_text "Act 1894, the six figure number allocated at that time should be removed prior to Carving", at: [lmargin + 10, vpos]
    vpos -= spacer
    @pdf.draw_text "and Marking the new Official Number", at: [lmargin + 10, vpos]
    vpos -= spacer + 10
    @pdf.draw_text "(2) The vessel is to be marked as follows:", at: [lmargin, vpos]
    vpos -= spacer
    @pdf.draw_text "(a) the name of the vessel and the port of choice must be painted in white on a black background", at: [lmargin + 10, vpos]
    vpos -= spacer
    @pdf.draw_text "or in black on a white background outside the stern of the boat in letters which shall not be", at: [lmargin + 25, vpos]
    vpos -= spacer
    @pdf.draw_text " less than 8 centimetres in height and 1.5 centimetres in breadth, and", at: [lmargin + 25, vpos]
    vpos -= spacer
    @pdf.draw_text "(b) the port letters and the number of the vessel must be painted or displayed on both sides of", at: [lmargin + 10, vpos]
    vpos -= spacer
    @pdf.draw_text "the bow and on each quarter, as high above the water as possible so as to be clearly visible", at: [lmargin + 25, vpos]
    vpos -= spacer
    @pdf.draw_text " from the sea and the air, in white on a black background or black on a white background;", at: [lmargin + 25, vpos]
    vpos -= spacer
    @pdf.draw_text "(c) for vessels not over 17 metres in length, the height of the port letters and numer to be at", at: [lmargin + 10, vpos]
    vpos -= spacer
    @pdf.draw_text "least 25 centimetres with a line thickness of at least 4 centimetres;", at: [lmargin + 25, vpos]
    vpos -= spacer
    @pdf.draw_text "(d) for vessels over 17 metres in length, the height of the port letters and numbers to be at", at: [lmargin + 10, vpos]
    vpos -= spacer
    @pdf.draw_text "least 45 centimetres with a line thickness of at least 6 centimetres;", at: [lmargin + 25, vpos]
    vpos -= spacer
    @pdf.draw_text "(e) the port letters and numbers shall in addition be painted or displayed on the wheel house", at: [lmargin + 10, vpos]
    vpos -= spacer
    @pdf.draw_text "top or some other prominent horizontal surface.", at: [lmargin + 25, vpos]
    vpos -= spacer
    @pdf.draw_text "", at: [lmargin + 10, vpos]
    vpos -= spacer
    @pdf.draw_text "", at: [lmargin + 10, vpos]
  end
end
# rubocop:enable all
