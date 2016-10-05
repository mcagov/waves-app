class RegistrationCertificate
  def initialize(vessel)
    @vessel = vessel
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

  def page_1_template
    "#{Rails.root}/public/certificates/part_3_front.png"
  end

  def page_2_template
    "#{Rails.root}/public/certificates/part_3_rear.png"
  end

  def details
    draw_value(
      @vessel.registered_until.to_s(:dasherize),
      at: [57, 300])
    draw_value @vessel.reg_no, at: [182, 300]
    draw_label_value "Description", @vessel.vessel_type.upcase, at: [34, 265]
    draw_label_value "Overall Length", @vessel.length_in_meters, at: [34, 250]
    draw_label_value "Number of Hulls", @vessel.number_of_hulls, at: [34, 235]
    draw_label_value "Name of Ship", @vessel, at: [34, 220]
    draw_label_value "Hull ID Number", @vessel.hin, at: [34, 205]
  end

  def owners
    offset = 0
    @vessel.owners.each do |owner|
      draw_value owner, at: [40, 157 - offset]
      offset += 12
    end
  end

  def registration_date
    default_value_font
    @pdf.draw_text @vessel.registered_at, at: [60, 27]
  end

  def draw_label_value(label, text, opts)
    default_label_font
    @pdf.text_box("#{label} :", opts.merge(align: :right, width: 80))
    default_value_font
    @pdf.draw_text(text, at: [opts[:at][0] + 85, opts[:at][1] - 7])
  end

  def draw_value(text, opts = {})
    default_value_font
    @pdf.draw_text(text, opts)
  end

  def watermark
    @pdf.transparent(0.1) do
      @pdf.draw_text "COPY OF ORIGINAL", at: [60, 10], rotate: 60, size: 44
    end
  end

  def default_value_font
    @pdf.font("Helvetica-BoldOblique", size: 10)
  end

  def default_label_font
    @pdf.font("Helvetica-Oblique", size: 10)
  end
end
