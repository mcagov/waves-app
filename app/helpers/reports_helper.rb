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
    [] + report.filter_attributes[filter_attr].map do |attr|
      [attr.name, "fields_#{filter_attr}_#{attr.key}"]
    end
  end
end
