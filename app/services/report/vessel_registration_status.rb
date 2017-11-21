class Report::VesselRegistrationStatus < Report
  def initialize(filters = {})
    super
    @registration_status = (@filters[:registration_status] || :all).to_sym
  end

  def title
    "Vessel Registration Status"
  end

  def filter_fields
    [:filter_part, :filter_registration_status, :filter_date_range]
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

  def results # rubocop:disable Metrics/MethodLength
    @pagination_collection = vessels
    @pagination_collection.map do |vessel|
      Result.new(
        [
          RenderAsLinkToVessel.new(vessel, :name),
          Activity.new(vessel.part),
          vessel.reg_no, vessel.radio_call_sign,
          vessel.registered_until,
          RenderAsRegistrationStatus.new(vessel.registration_status)
        ])
    end
  end

  def vessels
    query = Register::Vessel.joins(:current_registration)
    query = filter_by_part(query)
    query = filter_by_registered_until(query)
    query = filter_by_registration_status(query)
    paginate(query.order(:name))
  end

  private

   # rubocop:disable all
  def filter_by_registration_status(query)
    return query if @registration_status == :all

    if @registration_status == :frozen
      return query.where("vessels.frozen_at IS NOT NULL")
    else
      query = query.where("vessels.frozen_at IS NULL")
    end

    if @registration_status == :closed
      return query.where("registrations.closed_at IS NOT NULL")
    else
      query = query.where("registrations.closed_at IS NULL")
    end

    if @registration_status == :expired
      return query.where("date(registrations.registered_until) < ?", Date.today)
    else
      # registered
      query.where("date(registrations.registered_until) >= ?", Date.today)
    end

    if @registration_status == :registered_provisionally
      return query.where("registrations.provisional = TRUE")
    else
      query = query.where("registrations.provisional != TRUE")
    end

  end
  # rubocop:enable all
end
