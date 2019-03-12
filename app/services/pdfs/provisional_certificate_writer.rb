class Pdfs::ProvisionalCertificateWriter < Pdfs::CertificateWriter
  private

  def write_attachable(print_watermark = true)
    @pdf.start_new_page
    @pdf.image page_1_template, scale: 0.5
    watermark if print_watermark
    draw_registration_details
    draw_owners
    draw_date
    @pdf.start_new_page
    @pdf.image page_2_template, scale: 0.5
    watermark  if print_watermark
    @pdf
  end

  def write_printable
    write_attachable(false)
  end

  def draw_registration_details
    @pdf.draw_text @registration.registered_until, at: [290, 645]
    @pdf.draw_text @vessel.name, at: [232, 560]
    @pdf.draw_text @vessel.hin, at: [232, 524]
    @pdf.draw_text @vessel.register_length, at: [512, 522]
    @pdf.draw_text @vessel.vessel_type_description, at: [232, 444]
  end

  def draw_owners # rubocop:disable Metrics/MethodLength
    @pdf.font("Helvetica", size: 9)
    y_pos = 350
    @owners.flatten.each do |owner|
      @pdf.draw_text owner.shares_held, at: [474, y_pos - 10]
      @pdf.text_box "#{owner.name}, #{owner.inline_address}",
                    at: [80, y_pos], width: 300, height: 25
      y_pos -= 25
    end

    @registration.shareholder_groups.each do |shareholder_group|
      @pdf.draw_text shareholder_group[:shares_held], at: [474, y_pos - 10]
      @pdf.draw_text shareholder_group[:shareholder_names].join(", "),
                     at: [80, y_pos], width: 300, height: 25
      y_pos -= 25
    end
  end

  def draw_date
    @pdf.font("Helvetica", size: 11)
    @pdf.draw_text @registration.registered_at, at: [400, 90]
  end

  def page_1_template
    "#{Rails.root}/public/pdf_images/provisional_front.png"
  end

  def page_2_template
    "#{Rails.root}/public/pdf_images/provisional_rear.png"
  end

  def watermark
    @pdf.transparent(0.1) do
      @pdf.draw_text "COPY OF ORIGINAL", at: [100, 100], rotate: 60, size: 88
    end
  end
end
