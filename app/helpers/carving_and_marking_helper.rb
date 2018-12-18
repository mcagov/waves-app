module CarvingAndMarkingHelper
  def carving_and_marking_email_body(part)
    case part
    when :part_1
      carving_and_marking_part_1_email_body
    when :part_2
      carving_and_marking_part_2_email_body
    when :part_4
      carving_and_marking_part_4_email_body
    end
  end

  # rubocop:disable Metrics/MethodLength
  def carving_and_marking_part_1_email_body
    %(<div>VESSEL NAME: #{@submission.vessel}</div>
    <div>Please find enclosed the Carving and Marking
    Note for the above vessel.
    <br><br>If your vessel is a Pleasure vessel under 24m in
    length it can be signed by the owners or an
    Inspector of Marks/Authorised Measurer.
    <br><br>If your Pleasure vessel is over 24m in length or
    a Commercial vessel, it must be signed by an
    Inspector of Marks/Authorised Measurer
    <br><br>Regulation 35 of the Merchant Shipping (Registration of Ships)
    Regulations 1993 states that a carving and marking note
    should be returned completed to the Registrar within three months.
    <br><br>[FREE TEXT]
    <br><br>We also require the following documents:
    <br><br>[FREE TEXT]
    <br><br>The documents can be emailed to:
    <br><br>Pleasure vessels: part1.registry@mcga.gov.uk
    Commercial vessels: comm.registry@mcga.gov.uk
    <br><br>
    Alternatively, please post to:
    MCA
    Anchor Court
    Keen Road
    Cardiff
    CF24 5JW
    <br><br>
    Please do not hesitate to contact us if you require any further assistance.
    </div>
    )
  end
  # rubocop:enable Metrics/MethodLength

  # rubocop:disable Metrics/MethodLength
  def carving_and_marking_part_2_email_body
    %(<div>VESSEL NAME: #{@submission.vessel}</div>
    <div>Please find enclosed the Carving and Marking Note for the above vessel.
    <br><br>Please arrange for an MCA surveyor or Authorised Surveyor/Inspector
    of Marks to certify that the Carving and Markings are correct and return
    the form to this office.
    <br><br>Regulation 35 of the Merchant Shipping (Registration of Ships)
    Regulations 1993 states that a carving and marking note should be
    returned to the Registrar within three months.
    <br><br>We also require the following documents:

    <br>• Certificate of Measurement/Survey – Completed by a
    MCA Surveyor/Authorised Surveyor
    <br>• Valid Safety Certificate – Completed by a
    MCA surveyor
    <br>• [ITC 69 issued by Authorised Measurer] –
    [delete if not required (for over 24m only)]

    <br><br>
    Please do not hesitate to contact us you require any further assistance.
    </div>)
  end
  # rubocop:enable Metrics/MethodLength

  # rubocop:disable Metrics/MethodLength
  def carving_and_marking_part_4_email_body
    %(<div>VESSEL NAME: #{@submission.vessel}</div>
    <div>Please find enclosed the Carving and Marking Note for the above vessel.
    <br><br>A Commercial Bareboat Charter Carving and Marking Note must be
    signed by an Inspector of Marks/Authorised Measurer

    <br><br>Regulation 35 of the Merchant Shipping (Registration of Ships)
    Regulations 1993 states that a carving and marking note should be
    returned completed to the Registrar within three months.

    <br><br>[FREE TEXT]
    <br><br>We also require the following documents:
    <br><br>[FREE TEXT]
    <br><br>The documents can be emailed to:
    Commercial vessels: comm.registry@mcga.gov.uk
    <br><br>
    Alternatively, please post to:
    MCA
    Anchor Court
    Keen Road
    Cardiff
    CF24 5JW

    <br><br>
    Please do not hesitate to contact us you require any further assistance.
    </div>)
  end
  # rubocop:enable Metrics/MethodLength
end
