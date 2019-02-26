module ReportsHelper
  def report_field(data_element) # rubocop:disable Metrics/MethodLength
    if data_element.is_a?(Report::RenderAsRegistrationStatus)
      render_registration_status(data_element)

    elsif data_element.is_a?(Report::RenderAsLinkToVessel)
      render_link_to_vessel(data_element)

    elsif data_element.is_a?(Report::RenderAsLinkToSubmission)
      render_link_to_submission(data_element)

    elsif data_element.is_a?(Report::RenderAsDownloadLink)
      render_link_to_download(data_element)

    elsif data_element.is_a?(Report::RenderAsCurrency)
      formatted_amount(data_element.amount)

    else
      data_element
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

  def render_link_to_submission(data_element)
    link_to data_element.to_s, submission_path(data_element.submission.id)
  end

  def render_link_to_download(data_element)
    link_to(
      "Download (you will receive an email with a link to download the report)",
      "/admin/reports/#{data_element.report_key}.xls?#{request.query_string}")
  end
end
