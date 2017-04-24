class Pdfs::Part3::TranscriptWriter < Pdfs::TranscriptWriter
  private

  def page_title_for_part
    "OF A BRITISH SHIP"
  end

  def owner_details_for_part
    i = 0
    @owners.each do |owner|
      @pdf.font("Helvetica", size: 12)
      @pdf.draw_text owner.name, at: [l_margin, 700 - i]
      @pdf.text_box owner.inline_address, width: 500, at: [l_margin, 690 - i]
      i += 60
    end
  end
end
