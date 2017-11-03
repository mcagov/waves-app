class Report::VesselRegistrationStatus < Report
  def title
    "Vessel Registration Status"
  end

  def filter_fields
    [:filter_part, :filter_registration_status, :filter_date_range]
  end

  def headings
    [
      :vessel_name, :part, :official_no, :radio_call_sign,
      :port, "Date of Closure & Reason", :mortgage_registered,
      :expiration_date, :registration_status
    ]
  end

  def date_range_label
    "Expiration Date"
  end

  def results
    @pagination_collection = vessels
    @pagination_collection.map do |vessel|
      assign_result(vessel)
    end
  end

  def vessels
    query = Register::Vessel
    query = filter_by_part(query)
    query = filter_by_registered_until(query)
    query = query.includes(:current_registration, :mortgages)
    query = query.references(:current_registration)
    query = query.order(:name)
    paginate(query)
  end

  def assign_result(vessel) # rubocop:disable Metrics/MethodLength
    Result.new(
      [
        RenderAsLinkToVessel.new(vessel, :name),
        Activity.new(vessel.part),
        vessel.reg_no, vessel.radio_call_sign,
        WavesUtilities::Port.new(vessel.port_code).name,
        date_of_closure_and_reason(vessel.current_registration),
        mortgage_registered?(vessel),
        vessel.registered_until,
        RenderAsRegistrationStatus.new(vessel.registration_status)
      ])
  end

  def date_of_closure_and_reason(registration)
    if registration && registration.closed_at?
      "#{registration.closed_at}: #{registration.description}"
    end
  end

  def mortgage_registered?(vessel)
    vessel.mortgages.not_discharged.empty? ? "N" : "Y"
  end
end
