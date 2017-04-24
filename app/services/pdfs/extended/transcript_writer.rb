# rubocop:disable all
class Pdfs::Extended::TranscriptWriter < Pdfs::TranscriptWriter
  private

  def owner_details_for_part
    i = 0

    @pdf.font("Helvetica-Bold", size: 12)
    @pdf.draw_text "Name & Address", at: [l_margin, 710 - i]
    @pdf.draw_text "Shares Held", at: [474, 710 - i]
    i += 20

    @owners.each do |owner|
      @pdf.font("Helvetica", size: 12)
      @pdf.draw_text owner.name, at: [l_margin, 700 - i]
      @pdf.text_box owner.inline_address, width: 400,
        at: [l_margin, 694 - i]

      @pdf.draw_text owner.shares_held, at: [474, 690 - i]
      i += 60
    end

    @registration.shareholder_groups.each do |shareholder_group|
      @pdf.draw_text shareholder_group[:shareholder_names].join(", "), at: [l_margin, 700 - i]
      @pdf.draw_text shareholder_group[:shares_held], at: [474, 700 - i]
      i += 25
    end
  end
end
# rubocop:enable all
