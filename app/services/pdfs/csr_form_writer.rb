# rubocop:disable all
class Pdfs::CsrFormWriter
  def initialize(csr_form, pdf, template = :current)
    @csr_form = csr_form
    @vessel = csr_form.registered_vessel
    @pdf = pdf
    @template = template
  end

  def write
    @pdf.start_new_page
    draw_heading
    @pdf.bounding_box([l_margin, 750], width: table_width) do
      draw_information
      draw_certify
    end
    @pdf
  end

  private

  def draw_heading
    @pdf.image "#{Rails.root}/public/pdf_images/mca_color_logo.png",
               at: [l_margin, 810], scale: 0.2
    @pdf.font("Helvetica-Bold", size: 16)
    @pdf.draw_text "FORM 1 CONTINUOUS SYNOPSIS RECORD (CSR)",
                  at: [120, 790]
    @pdf.font("Helvetica", size: 11)
    @pdf.draw_text "DOCUMENT NUMBER #{issue_number} FOR THE SHIP WITH IMO NUMBER: #{imo_number}",
                  at: [130, 770]
  end

  def draw_information
    @pdf.table(information_table_data,
               width: table_width,
               column_widths: [20, 290, 210],
               cell_style: { size: 9, padding: 3 }) do
      row(0).style(background_color: "F0F0F0", align: :center, font: "Helvetica-Bold", font_size: "12")
    end
  end

  def draw_certify
    @pdf.move_down 20
    @pdf.text "THIS IS TO CERTIFY THAT this record is correct in all respects."
    @pdf.move_down 10
    @pdf.text "Issued by the Administration of: United Kingdom."
    @pdf.move_down 15
    @pdf.draw_text "Place of Issue: Cardiff", at: [0, @pdf.cursor]
    @pdf.draw_text "Date of issue: #{@csr_form.issued_at}", at: [r_col_pos, @pdf.cursor]
    @pdf.move_down 12
    @pdf.image "#{Rails.root}/public/pdf_images/registrar_signature.png", at: [0, @pdf.cursor], scale: 0.2
    @pdf.move_down 20
    @pdf.draw_text " David Jones. Registrar General of the United Kingdom Shipping Register.", at: [90, @pdf.cursor]
    @pdf.move_down 25
    @pdf.text "This document was received by the ship and attached to the ship's CSR file on the following date:"
    @pdf.move_down 30

    @pdf.fill_color "808080"
    @pdf.draw_text "------------------------------------------", at: [0, @pdf.cursor]
    @pdf.draw_text "------------------------------------------", at: [r_col_pos, @pdf.cursor]
    @pdf.move_down 8
    @pdf.draw_text "Date", at: [0, @pdf.cursor]
    @pdf.draw_text "Signature", at: [r_col_pos, @pdf.cursor]
  end

  def issue_number
    @csr_form.issue_number
  end

  def imo_number
    @vessel.imo_number
  end

  def table_width
    520
  end

  def l_margin
    40
  end

  def r_col_pos
    300
  end

  def information_table_data
    [
      [{ content: "INFORMATION", colspan: 3 }],

      ["1", "This document applies from (date):", @csr_form.issued_at.to_s],

      ["2", "Flag State:", @csr_form.flag_state.to_s],

      ["3", "Date of registration with the State indicated in 2:", @csr_form.registered_at.to_s],

      ["4", "Name of ship:", @csr_form.vessel_name.to_s],

      ["5", "Port of registration:", @csr_form.port_name.to_s],

      ["6", "Name of current registered owner(s):\n\nRegistered address(es):",
        "#{@csr_form.owner_names}\n\n#{@csr_form.owner_addresses}"],

      ["7", "Registered owner identification number:", @csr_form.owner_identification_number.to_s],

      ["8", "If applicable, name of current registered bareboat charterer(s):\n\nRegistered address(es):",
        "#{@csr_form.charterer_names}\n\n#{@csr_form.charterer_addresses}"],

      ["9", "Name of Company (International Safety Management):\n\nRegistered address(es):\n\nAddress(es) of its Safety Management activities (if different):",
        "#{@csr_form.manager_name}\n\n#{@csr_form.manager_address}\n\n#{@csr_form.safety_management_address}"],

      ["10", "Company identification number:", @csr_form.manager_company_number.to_s],

      ["11", "Name of all classification societies with which the ship is classed:", @csr_form.classification_societies.to_s],

      ["12", "Administration / Government / Recognised Organisation which issued the Document of Compliance:\n\nBody which carried out audit (if different):",
        "#{@csr_form.document_of_compliance_issuer}\n\n#{@csr_form.document_of_compliance_auditor}"],

      ["13", "Administration / Government / Recognised Organisation which issued the Safety Management Certificate:\n\nBody which carried out audit (if different):",
        "#{@csr_form.smc_issuer}\n\n#{@csr_form.smc_auditor}"],

      ["14", "Administration / Government / Recognised Organisation which issued the International Ship Security Certificate:\n\nBody which carried out the verification (if different):]",
        "#{@csr_form.issc_issuer}\n\n#{@csr_form.issc_auditor}"],

      ["15", "Date on which the ship ceased to be registered with the State indicated in 2:", @csr_form.registration_closed_at.to_s],

      ["16", "Remarks", @csr_form.remarks.to_s]
    ]
  end
end
# rubocop:enable all
