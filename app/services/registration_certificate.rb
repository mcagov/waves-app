class RegistrationCertificate
  def initialize(vessel, preview = true)
    @vessel = vessel
    @preview = preview
  end

  def render
    @pdf = Prawn::Document.new(margin: 0, page_size: "A6")
    @pdf.image page_1_template, scale: 0.48
    watermark
    details
    owners
    registration_date
    @pdf.start_new_page
    @pdf.image page_2_template, scale: 0.48
    watermark
    @pdf.render
  end

  def filename
    title = @vessel.to_s.parameterize
    reg_date = @vessel.registered_at.to_s(:db)
    "#{title}-registration-#{reg_date}.pdf"
  end

  private

  def set_default_font
    @pdf.fill_color("000000")
    @pdf.font("Helvetica", size: 10)
  end

  def page_1_template
    "#{Rails.root}/public/certificates/part_3_front.png" if @preview
  end

  def page_2_template
    "#{Rails.root}/public/certificates/part_3_rear.png" if @preview
  end

  def details
    set_default_font
    @pdf.draw_text @vessel.registered_until, at: [17, 260]
    @pdf.draw_text @vessel.reg_no, at: [144, 260]
    @pdf.draw_text @vessel.vessel_type.upcase, at: [84, 210]
    @pdf.draw_text @vessel.length_in_meters, at: [84, 194]
    @pdf.draw_text @vessel.number_of_hulls, at: [84, 178]
    @pdf.draw_text @vessel, at: [84, 164]
    @pdf.draw_text @vessel.hin, at: [84, 149]
  end

  def owners
    set_default_font
    offset = 0
    @vessel.owners.each do |owner|
      @pdf.draw_text owner, at: [0, 118 - offset]
      offset += 12
    end
  end

  def registration_date
    set_default_font
    @pdf.draw_text @vessel.registered_at, at: [34, -14]
  end

  def watermark
    @pdf.transparent(0.1) do
      @pdf.draw_text "COPY OF ORIGINAL",
      at: [60, 10], rotate: 60, size: 44
    end
  end
end
