# rubocop:disable all
class Pdfs::TranscriptWriter
  def initialize(registration, pdf, template = :current)
    @registration = registration
    @vessel = Decorators::Vessel.new(@registration.vessel)
    @owners = @registration.owners
    @pdf = pdf
    @template = template
  end

  def write
    @pdf.start_new_page
    draw_logo
    draw_title
    draw_heading
    draw_vessel
    draw_footer
    draw_page_2
    @pdf
  end

  protected

  def draw_logo
    @pdf.image "#{Rails.root}/public/pdf_images/mca_color_logo.png",
               at: [20, 830], scale: 0.25
  end

  def draw_title
    @pdf.move_down 90
    @pdf.stroke_horizontal_rule
    @pdf.font("Helvetica-Bold", size: 24)
    @pdf.text_box page_title_line_1,
                  at: [0, 740], width: 590, height: 200, align: :center
    @pdf.text_box page_title_for_part,
                  at: [0, 715], width: 590, height: 200, align: :center
    @pdf.font("Helvetica", size: 11)
    @pdf.move_down 65
    @pdf.stroke_horizontal_rule
  end

  def draw_heading
    @pdf.font("Helvetica-Bold", size: 16)
    @pdf.text_box "PARTICULARS OF SHIP",
                  at: [0, 674], width: 590, height: 200, align: :center
    @pdf.move_down 35
    @pdf.stroke_horizontal_rule
  end

  def draw_vessel
    vessel_details_for_part
  end

  def draw_footer
    @pdf.move_down 440
    @pdf.stroke_horizontal_rule
    @pdf.font("Helvetica", size: 11)
    @pdf.formatted_text_box certification_text,
      at: [l_margin, 204], width: 500, height: 200

    @pdf.text_box "Signed: ____________________________________________",
                   at: [0, 150], height: 200, align: :center

    @pdf.font("Helvetica-Bold", size: 11)
    i = 0
    for_and_on_behalf_of_text_lines.each do |line|
      @pdf.text_box line,
        at: [l_margin, 120 - i], width: 500, align: :center
        i += 12
    end
  end

  def draw_page_2
    @pdf.start_new_page
    @pdf.font("Helvetica", size: 11)
    @pdf.draw_text "For the purposes of registration there "\
                   "are 64 shares in a British Ship",
                   at: [l_margin, 800]

    @pdf.move_down 60
    @pdf.stroke_horizontal_rule

    @pdf.draw_text "The following details show the current ownership and "\
                   "shareholding of",
                   at: [l_margin, 760]
    @pdf.draw_text "#{@vessel.name} O.N. #{@vessel.reg_no}",
                   at: [l_margin, 746]

    @pdf.move_down 50

    @pdf.stroke_horizontal_rule

    owner_details_for_part

    @pdf.text_box "Page 2 of 2", width: 500,
        at: [262, 40]
  end

  def page_title_line_1
    case @template
    when :current
      "TRANSCRIPT OF #{'CLOSED ' if @registration.closed_at}REGISTRY"
    when :historic
      "HISTORIC TRANSCRIPT OF REGISTRY"
    end
  end

  def certification_text
    s = "I certify that this transcript consisting of 2 pages is a true extract"
    s += " from #{Activity.new(@vessel.part)} of the Register"
    s += " now in my charge showing descriptive particulars, registered"
    s += " ownerships and mortgages, if any, as at "
    [
      { text: s },
      { text: @registration.created_at.to_s, styles: [:bold] },
      { text: "." }
    ]
  end

  def for_and_on_behalf_of_text_lines
    s = ["For and on behalf of The Registrar General of Shipping and Seamen"]
    s << "UK Ship Register"
    s << "Anchor Court"
    s << "Keen Road"
    s << "Cardiff"
    s << "CF24 5JW"
    s
  end
end
# rubocop:enable all
