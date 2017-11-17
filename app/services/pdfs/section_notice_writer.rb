class Pdfs::SectionNoticeWriter
  include Pdfs::Stationary

  def initialize(section_notice, pdf)
    @section_notice = section_notice
    @vessel = @section_notice.noteable

    @pdf = pdf
  end

  def write
    @vessel.owners.each do |owner|
      @pdf.start_new_page
      @applicant_name = owner.name
      @delivery_name_and_address = [owner.name] + owner.compacted_address
      init_stationary(@section_notice.updated_at)
      vessel_name
      message
    end
    @pdf
  end

  protected

  def vessel_name
    set_bold_font
    @pdf.draw_text @vessel.name, at: [l_margin, 530]
  end

  def message
    set_copy_font
    @pdf.draw_text "Section Notice!", at: [l_margin, 510]
    @pdf.draw_text "Regulation/Reason: #{@section_notice.subject}",
                   at: [l_margin, 410]
    @pdf.draw_text "Evidence required: #{@section_notice.content}",
                   at: [l_margin, 310]
  end
end
