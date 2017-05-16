# rubocop:disable all
class Pdfs::Extended::TranscriptWriter < Pdfs::TranscriptWriter
  private

  def owner_details_for_part
    y_pos = 700
    @owners.each do |owner|
      next if owner.shares_held == 0
      @pdf.draw_text owner.name, at: [l_margin, y_pos]
      @pdf.text_box owner.inline_address, width: 400, height: 30, at: [l_margin, y_pos - 5]
      @pdf.draw_text owner.shares_held, at: [474, y_pos]
      y_pos -= 50
    end

    @registration.shareholder_groups.each do |shareholder_group|
      @pdf.draw_text shareholder_group[:shares_held], at: [474, y_pos]

      next unless shareholder_group[:owners].present?

      shareholder_group[:owners].each do |owner|
        default_label_font
        @pdf.draw_text owner[:name], at: [l_margin, y_pos]
        @pdf.text_box owner[:inline_address], width: 400, height: 30, at: [l_margin, y_pos - 5]

        unless owner == shareholder_group[:owners].last
          default_value_font
          @pdf.draw_text "jointly with", at: [l_margin - 3, y_pos - 40]
          y_pos -= 55
        else
          y_pos -= 40
        end
      end
    end
  end

  def draw_label_value(label, text, opts)
    default_label_font
    @pdf.text_box("#{label}", opts.merge(width: 130))
    default_value_font
    @pdf.draw_text(text, at: [opts[:at][0] + 145, opts[:at][1] - 7])
  end

  def draw_value(text, opts = {})
    default_value_font
    @pdf.draw_text(text, opts)
  end

  def default_value_font
    @pdf.font("Helvetica-Bold", size: 11)
  end

  def default_label_font
    @pdf.font("Helvetica", size: 11)
  end

  def l_margin
    40
  end

end
# rubocop:enable all
