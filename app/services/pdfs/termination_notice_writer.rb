class Pdfs::TerminationNoticeWriter
  include Pdfs::Stationary

  def initialize(section_notice, pdf)
    @section_notice = section_notice
    @vessel = @section_notice.vessel

    @pdf = pdf
  end

  def write
    @vessel.owners.each do |owner|
      @pdf.start_new_page
      @applicant_name = owner.name
      @delivery_name_and_address = [owner.name] + owner.compacted_address
      init_stationary(@section_notice.updated_at)
      vessel_name
      page_one
      @pdf.start_new_page
      page_two(owner)

      @pdf = Pdfs::SectionNoticeWriter.new(@section_notice, @pdf).write
    end
    @pdf
  end

  protected

  def vessel_name
    set_bold_font
    msg = [@vessel.vessel_type]
    msg << @vessel.name
    msg << @vessel.reg_no
    @pdf.text_box "RE: #{msg.compact.join(", ")}",
                  at: [l_margin, 530],
                  width: 480, height: 100, leading: 8
  end

  def page_one
    set_copy_font
    @pdf.draw_text "PAGE 1", at: [l_margin, 510]
  end

  def page_two(owner)
    set_copy_font
    @pdf.draw_text "PAGE 2", at: [l_margin, 510]
  end
end
