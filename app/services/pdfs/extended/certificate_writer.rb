class Pdfs::Extended::CertificateWriter < Pdfs::CertificateWriter
  private

  def write_attachable
    @pdf.start_new_page
    @pdf.image page_1_template, scale: 0.4796
    watermark
    vessel_details
    registration_details
    @pdf.start_new_page
    @pdf.image page_2_template, scale: 0.4796
    owner_details
    watermark
  end

  def write_printable
    @pdf.start_new_page
    vessel_details
    registration_details
    @pdf.start_new_page
    owner_details
  end

  def page_1_template
    "#{Rails.root}/public/pdf_images/extended_front.png"
  end

  def page_2_template
    "#{Rails.root}/public/pdf_images/extended_rear.png"
  end

  # rubocop:disable all
  def registration_details
    default_label_font
    @pdf.text_box("This Certificate was issued on:", at: [lmargin, 220], width: 220)
    @pdf.text_box("This Certificate expires on:", at: [lmargin, 190])
    default_value_font
    @pdf.draw_text(@registration.registered_at.to_s(:date_time), at: [240, 213])
    @pdf.draw_text(@registration.registered_until.to_s(:date_summary), at: [240, 183])
  end

  def owner_details
    y_pos = 730
    @owners.each do |owner|
      next if owner.shares_held == 0
      draw_label owner.name, at: [lmargin, y_pos]
      @pdf.text_box owner.inline_address, width: 400, height: 30, at: [lmargin, y_pos - 5]
      draw_label owner.shares_held, at: [474, y_pos]
      y_pos -= 40
    end

    @registration.shareholder_groups.each do |shareholder_group|
      draw_label shareholder_group[:shareholder_names].join(", "), at: [lmargin, y_pos]
      draw_label shareholder_group[:shares_held], at: [474, y_pos]
      y_pos -= 25
    end

    display_charterers(y_pos)
  end
  # rubocop:enable all

  def display_charterers(y_pos)
    # intentionally left blank
  end

  def draw_label_value(label, text, opts)
    default_label_font
    @pdf.text_box("#{label}:", opts.merge(width: 140)) if label.present?
    default_value_font
    @pdf.draw_text(text, at: [opts[:at][0] + 140, opts[:at][1] - 7])
  end

  def draw_value(text, opts = {})
    default_value_font
    @pdf.draw_text(text, opts)
  end

  def draw_label(text, opts = {})
    default_label_font
    @pdf.draw_text(text, opts)
  end

  def lmargin
    40
  end

  def watermark
    @pdf.transparent(0.1) do
      @pdf.draw_text "COPY OF ORIGINAL", at: [60, 10], rotate: 60, size: 94
    end
  end
end
