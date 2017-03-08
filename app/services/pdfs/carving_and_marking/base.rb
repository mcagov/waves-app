# rubocop:disable all
class Pdfs::CarvingAndMarking::Base
  def initialize(carving_and_marking_note, pdf, mode = :printable)
    @carving_and_marking_note = carving_and_marking_note
    @submission = @carving_and_marking_note.submission
    @vessel = @submission.vessel
    @pdf = pdf
    @mode = mode
  end

  def write
    @pdf.start_new_page
    draw_logo
    draw_title
    draw_vessel
    draw_marking_notes
    draw_certify
    @pdf.start_new_page
    draw_instructions_title
    draw_instructions
    @pdf
  end

  def set_bold_font
    @pdf.font("Helvetica-Bold", size: 11)
  end

  def set_copy_font
    @pdf.font("Helvetica", size: 11)
  end

  private

  def draw_logo
    @pdf.image "#{Rails.root}/public/pdf_images/mca_transcript_logo.png",
               at: [233, 820], scale: 0.3
  end

  def draw_title
    set_bold_font
    @pdf.draw_text "CARVING AND MARKING NOTE",
                  at: [214, 730]
    @pdf.text_box title_text, at: [100, 720], width: 400, align: :center
    @pdf.text_box warning_text, at: [lmargin, 680], width: 500
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

  def draw_instructions_title
    @pdf.font("Helvetica-Bold", size: 12)
    @pdf.draw_text "INSTRUCTIONS FOR CARVING AND MARKING", at: [160, 790]
  end

  def warning_text
    "*WARNING: THE VESSEL IS NOT REGISTERED UNTIL THIS CERTIFICATE "\
    "IS RETURNED TO THE REGISTRY AND A CERTIFICATE OF REGISTRY "\
    "IS ISSUED"
  end

  def lmargin
    40
  end
end
# rubocop:enable all
