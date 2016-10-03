bg = "#{Rails.root}/public/certificates/part_3.png"
prawn_document(background: bg, page_size: "A6") do |pdf|

  pdf.font("Helvetica", size: 10) do
    pdf.draw_text @vessel.registered_until, at: [17, 260]
    pdf.draw_text @vessel.reg_no, at: [144, 260]

    pdf.draw_text @vessel.vessel_type.upcase, at: [84, 210]
    pdf.draw_text @vessel.length_in_meters, at: [84, 194]
    pdf.draw_text @vessel.number_of_hulls, at: [84, 178]
    pdf.draw_text @vessel, at: [84, 164]
    pdf.draw_text @vessel.hin, at: [84, 149]

    offset = 0
    @vessel.owners.each do |owner|
      pdf.draw_text owner, at: [0, 118 - offset]
      offset += 12
    end

    pdf.draw_text @vessel.registered_at, at: [34, -14]
  end
end
