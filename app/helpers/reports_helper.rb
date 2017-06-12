module ReportsHelper
  def report_field(data_element)
    if data_element.is_a?(Report::RenderAsRegistrationStatus)
      render_registration_status(data_element)

    elsif data_element.is_a?(Report::RenderAsLinkToVessel)
      render_link_to_vessel(data_element)

    elsif data_element.is_a?(Report::RenderAsDownloadLink)
      render_link_to_download(data_element)

    else
      data_element
    end
  end

  def report_operator_collection(datatype)
    case datatype
    when :numeric
      [
        ["Equals", :equals],
        ["Greater than", :greater_than],
        ["Less than", :less_than],
      ]
    else
      [["Includes", :includes], ["Excludes", :excludes]]
    end
  end

  def report_criteria_collection(report, filter_attr)
    [] + report.sections[filter_attr].map do |attr|
      [attr.name, "fields_#{filter_attr}_#{attr.key}"]
    end
  end

  def titleized_report_heading(val)
    val.is_a?(Symbol) ? val.to_s.titleize : val
  end

  private

  def render_registration_status(data_element)
    render partial: "/shared/registration_status",
           locals: { registration_status: data_element.registration_status }
  end

  def render_link_to_vessel(data_element)
    link_to data_element.vessel.send(data_element.attribute),
            vessel_path(data_element.vessel.id)
  end

  def render_link_to_download(data_element)
    link_to(
      "Download",
      "/admin/reports/#{data_element.report_key}.xls?#{request.query_string}")
  end
end
