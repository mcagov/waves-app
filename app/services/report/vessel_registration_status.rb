class Report::VesselRegistrationStatus < Report
  def title
    "Vessel Registration Status"
  end

  def filter_fields
    [:filter_part, :filter_date_range]
  end

  def headings
    [
      :vessel_name, :part, :official_no, :radio_call_sign,
      :expiration_date, :registration_status
    ]
  end

  def date_range_label
    "Expiration Date"
  end

  def results
    vessels.map do |vessel|
      Result.new(
        [
          vessel.name, Activity.new(vessel.part),
          vessel.reg_no, vessel.radio_call_sign,
          vessel.registered_until, vessel.registration_status
        ])
    end
  end

  def vessels
    query = Register::Vessel.includes(:current_registration)
    query = filter_by_part(query)
    query.order(:name).all
  end
end
