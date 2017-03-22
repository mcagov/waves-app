# rubocop:disable all
class Pdfs::CsrFormWriter
  def initialize(csr_form, pdf, template = :current)
    @csr_form = csr_form
    @pdf = pdf
    @template = template
  end

  def write
    @pdf.start_new_page
    draw_heading
    @pdf
  end

  private

  def draw_heading
    @pdf.font("Helvetica-Bold", size: 16)
    @pdf.text_box "PARTICULARS OF SHIP",
                  at: [0, 674], width: 590, height: 200, align: :center
    @pdf.move_down 35
    @pdf.stroke_horizontal_rule
  end

end
# rubocop:enable all
