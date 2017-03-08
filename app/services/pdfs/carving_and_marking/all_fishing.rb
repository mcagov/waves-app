# rubocop:disable all
class Pdfs::CarvingAndMarking::AllFishing < Pdfs::CarvingAndMarking::Base
  private

  def title_text
    "FISHING VESSELS ON PART I AND IV OF THE REGISTER"
  end

  def draw_vessel
    set_copy_font
    @pdf.bounding_box([lmargin, 645], width: 510) { @pdf.stroke_horizontal_rule }
    @pdf.draw_text "VESSEL NAME", at: [lmargin, 625]
    @pdf.draw_text "OFFICIAL NUMBER", at: [lmargin, 600]
    @pdf.draw_text "PORT OF CHOICE", at: [lmargin, 575]
    @pdf.draw_text "PORT LETTERS AND NUMBERS", at: [lmargin, 550]

    set_bold_font
    @pdf.draw_text @vessel.name, at: [300, 625]
    @pdf.draw_text @submission.vessel_reg_no, at: [300, 600]
    @pdf.draw_text @vessel.port_name, at: [300, 575]
    @pdf.draw_text @vessel.pln, at: [300, 550]

    @pdf.bounding_box([lmargin, 510], width: 510) { @pdf.stroke_horizontal_rule }
  end

  def draw_marking_notes
    set_copy_font
    @pdf.draw_text "The above vessel is to be marked with the following:", at: [lmargin, 490]
    @pdf.draw_text "- the official number to be conspicuously carved in the appropriate way", at: [lmargin + 20, 475]
    @pdf.draw_text "- the name and port of choice to be marked on the stern", at: [lmargin + 20, 460]
    @pdf.draw_text "- the port letters and number to be marked on both sides of the bow, on each quarter", at: [lmargin + 20, 445]
    @pdf.draw_text "- the port letters and number to be marked on both sides of the bow, on each quarter", at: [lmargin + 20, 430]
    @pdf.draw_text "and also on the wheel house top or some other prominent horizontal surface", at: [lmargin + 30, 415]
    @pdf.draw_text "in the manner prescribed overleaf", at: [lmargin + 30, 400]
    @pdf.bounding_box([lmargin, 390], width: 510) { @pdf.stroke_horizontal_rule }
  end

  def draw_instructions
    set_copy_font
    vpos = 760
    spacer = 18
    @pdf.draw_text "1. The vessel's official number must:", at: [lmargin, vpos]
    vpos -= spacer
    @pdf.draw_text "(a) be carved into the wood beam of the vessel, or", at: [lmargin + 10, vpos]
    vpos -= spacer
    @pdf.draw_text "(b) if there is no beam, be carved on a readily accessible visible permanent part of the structure of the", at: [lmargin + 10, vpos]
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
    @pdf.draw_text "or in black on a white background on the stern of the boat in letters which shall not be less than", at: [lmargin + 25, vpos]
    vpos -= spacer
    @pdf.draw_text "8 centimetres in height and 1.5 centimetres in breadth, and", at: [lmargin + 25, vpos]
    vpos -= spacer
    @pdf.draw_text "(b) the port letters and the number of the vessel must be painted or displayed on both sides of", at: [lmargin + 10, vpos]
    vpos -= spacer
    @pdf.draw_text "the bow and on each quarter, as high above the water as possible so as to be clearly visible from the sea", at: [lmargin + 25, vpos]
    vpos -= spacer
    @pdf.draw_text "and the air, in white on a black backgroun or black on a white background;", at: [lmargin + 25, vpos]
    vpos -= spacer
    @pdf.draw_text "(c) for vessels not over 17 metres in length, the height of the port letters and numer to be at", at: [lmargin + 10, vpos]
    vpos -= spacer
    @pdf.draw_text "least 25 centimetres with a line thickness of at least 4 centimetres;", at: [lmargin + 25, vpos]
    vpos -= spacer
    @pdf.draw_text "(d) for vessels over 17 metres in length, the height of the port letters and number to be at", at: [lmargin + 10, vpos]
    vpos -= spacer
    @pdf.draw_text "least 25 centimetres with a line thickness of at least 6 centimetres;", at: [lmargin + 25, vpos]
    vpos -= spacer
    @pdf.draw_text "(e) the port letters and numbers shall in addition be painte or displayed on the wheel house", at: [lmargin + 10, vpos]
    vpos -= spacer
    @pdf.draw_text "top or some other prominent horizontal surface.", at: [lmargin + 25, vpos]
    vpos -= spacer
    @pdf.draw_text "", at: [lmargin + 10, vpos]
    vpos -= spacer
    @pdf.draw_text "", at: [lmargin + 10, vpos]
  end
end
# rubocop:enable all
