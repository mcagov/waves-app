module ReportsHelper
  def report_field(data_element)
    if data_element.is_a?(Report::RenderAsRegistrationStatus)
      render partial: "/shared/registration_status",
             locals: { registration_status: data_element.registration_status }
    else
      data_element
    end
  end
end
