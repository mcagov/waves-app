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
    @pdf.text_box warning_text, at: [lmargin, 690], width: 500
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
