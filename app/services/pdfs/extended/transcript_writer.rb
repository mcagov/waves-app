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

    mortgage_details_for_part(y_pos) if Policies::Definitions.mortgageable?(@vessel)
  end

  def mortgage_details_for_part(y_pos)
    y_pos -= 10
    @pdf.bounding_box([l_margin, y_pos], width: 510) { @pdf.stroke_horizontal_rule }

    @pdf.draw_text "The following details show the mortgages/mortgage intents "\
                   "(if any) registered against the",
                   at: [l_margin, y_pos - 20]
    @pdf.draw_text "#{@vessel.name} O.N. #{@vessel.reg_no} or shares in the ship",
                   at: [l_margin, y_pos - 34]

    @pdf.bounding_box([l_margin, y_pos - 44], width: 510) { @pdf.stroke_horizontal_rule }

    y_pos -= 70

    mortgages = @vessel.mortgages.not_discharged

    if mortgages.empty?
      default_value_font
      @pdf.draw_text "None", at: [l_margin, y_pos]
    end

    mortgages.each do |mortgage|
      default_value_font
      @pdf.draw_text "Current Ownership", at: [l_margin, y_pos]
      y_pos -= 15

      default_label_font
      @pdf.draw_text "Mortgage priority '#{mortgage.priority_code}'", at: [l_margin, y_pos]
      @pdf.draw_text "Type of mortgage:", at: [l_margin + 200, y_pos]
      default_value_font
      @pdf.draw_text mortgage.mortgage_type, at: [l_margin + 340, y_pos]
      y_pos -= 15

      default_label_font
      @pdf.draw_text "No of shares mortgaged:", at: [l_margin + 200, y_pos]
      default_value_font
      @pdf.draw_text mortgage.amount, at: [l_margin + 340, y_pos]
      y_pos -= 15

      default_label_font
      @pdf.draw_text "Mortgagor(s):", at: [l_margin, y_pos]
      y_pos -= 15

      default_value_font
      mortgage.mortgagors.each do |mortgagor|
        @pdf.draw_text mortgagor.name, at: [l_margin, y_pos]
        @pdf.text_box mortgagor.inline_address, width: 400, height: 30, at: [l_margin, y_pos - 5]

        y_pos -= 30
      end

      default_label_font
      @pdf.draw_text "Mortgagee(s):", at: [l_margin, y_pos]
      y_pos -= 15

      default_value_font
      mortgage.mortgagees.each do |mortgagee|
        @pdf.draw_text mortgagee.name, at: [l_margin, y_pos]
        @pdf.text_box mortgagee.inline_address, width: 500, height: 30, at: [l_margin, y_pos - 5]

        y_pos -= 30
      end

      default_label_font
      @pdf.draw_text "Date/Time registered", at: [l_margin, y_pos]
      default_value_font
      @pdf.draw_text mortgage.registered_at.to_s(:date_time), at: [l_margin + 140, y_pos]
      y_pos -= 15

      default_label_font
      @pdf.draw_text "Date executed", at: [l_margin, y_pos]
      default_value_font
      @pdf.draw_text mortgage.executed_at, at: [l_margin + 140, y_pos]
      y_pos -= 30
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
