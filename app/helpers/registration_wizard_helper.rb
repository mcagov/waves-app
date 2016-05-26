module RegistrationWizardHelper
  def form_checkbox(form, attribute)
    form.input(
      attribute,
      as: :boolean,
      wrapper: false,
      label_html: {class: "block-label"}
    )
  end

  def vessel_type_collection
    vessels = VesselType.all.each_with_object([]) do |vessel_type, memo|
      memo << [vessel_type.designation.titleize, vessel_type.id]
    end

    vessels << [nil, nil, {disabled: true}]
    vessels << ["Other (please specify)", nil]
  end
end
