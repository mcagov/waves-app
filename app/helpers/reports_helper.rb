module ReportsHelper
  def report_field(data_element)
    if data_element.is_a?(Report::RenderAsRegistrationStatus)
      render partial: "/shared/registration_status",
             locals: { registration_status: data_element.registration_status }

    elsif data_element.is_a?(Report::RenderAsLinkToVessel)
      link_to data_element.vessel.send(data_element.attribute),
              vessel_path(data_element.vessel.id)

    else
      data_element
    end
  end
end
