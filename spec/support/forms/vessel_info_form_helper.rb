def default_vessel_info_form_fields
  form_fields = attributes_for(:vessel, vessel_type: VesselType.all.sample)
  form_fields[:vessel_type_id] = form_fields[:vessel_type].id
  form_fields.delete(:vessel_type)

  form_fields
end

def complete_vessel_hin_field(fields)
  hin = fields.delete(:hin)

  return if hin.blank?

  page.fill_in("hin[prefix]", with: hin[0..1])
  page.fill_in("hin[suffix]", with: hin[3..-1])
end

def complete_vessel_length_in_centimeters_field(fields)
  length_in_centimeters = fields.delete(:length_in_centimeters)

  return if length_in_centimeters.blank?

  metres = length_in_centimeters / 100
  centimetres = length_in_centimeters % 100

  page.fill_in("length_in_centimeters[m]", with: metres.to_s)
  page.fill_in("length_in_centimeters[cm]", with: centimetres.to_s)
end

def complete_vessel_info_form(fields = default_vessel_info_form_fields)
  complete_vessel_hin_field(fields)
  complete_vessel_length_in_centimeters_field(fields)

  fill_form_and_submit(:vessel_info, :update, fields)
end
