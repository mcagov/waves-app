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
end
# rubocop:enable all
