module Pdfs::Stationary
  def init_stationary(sent_at)
    @sent_at = sent_at.to_date
    mca_logos
    mca_address
    date_and_ref unless @skip_date_and_ref
    delivery_address if @delivery_name_and_address
    greeting if @applicant_name
  end

  def l_margin
    45
  end

  def spacer
    14
  end

  def set_headline_font
    @pdf.font("Helvetica-Bold", size: 15)
  end

  def set_bold_font
    @pdf.font("Helvetica-Bold", size: 11)
  end

  def set_copy_font
    @pdf.font("Helvetica", size: 11)
  end

  def mca_logos
    @pdf.image "#{Rails.root}/public/pdf_images/mca_color_logo.png",
               at: [l_margin, 780], scale: 0.35

    @pdf.image "#{Rails.root}/public/pdf_images/mca_ensign.png",
               at: [l_margin, 80], scale: 0.18
  end

  def mca_address
    set_bold_font
    @pdf.draw_text "UK Ship Register", at: [340, 780]
    @pdf.draw_text "Anchor Court", at: [340, 766]
    @pdf.draw_text "KEEN ROAD", at: [340, 752]
    @pdf.draw_text "Cardiff", at: [340, 738]
    @pdf.draw_text "CF24 5JW", at: [340, 724]

    @pdf.draw_text "Tel: 0203 90 85200", at: [340, 700]
  end

  def date_and_ref
    set_bold_font
    @pdf.draw_text "Your Ref:", at: [340, 662]
    @pdf.draw_text "Our Ref: ", at: [340, 648]
    @pdf.draw_text "Date: ", at: [340, 634]
    set_copy_font
    @pdf.draw_text "", at: [400, 662]
    @pdf.draw_text(our_ref, at: [400, 648]) if @vessel
    @pdf.draw_text @sent_at.to_s(:formal), at: [400, 634]
  end

  def our_ref
    @registration.try(:submission_ref_no) || (@vessel || {})[:reg_no]
  end

  def delivery_address
    i = 0
    @delivery_name_and_address.each do |line|
      @pdf.draw_text line, at: [l_margin, 660 - i]
      i += spacer
    end
  end

  def greeting
    set_copy_font
    @pdf.draw_text "Dear #{@applicant_name}", at: [l_margin, 555]
  end
end
