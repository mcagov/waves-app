class Report::VesselDataRetention < Report
  def title
    "Vessel Data Retention"
  end

  def headings
    ["Name", "Official No", "Registration Expired", "Last Mortgage Discharged"]
  end

  def links_to_export_or_print?
    false
  end

  def results
    @pagination_collection = paginate(vessels)

    @pagination_collection.map do |vessel|
      data_elements =
        [
          RenderAsLinkToVessel.new(vessel, :name),
          vessel.reg_no,
          vessel.current_registration.try(:registered_until),
          vessel.latest_discharged_mortgage.try(:discharged_at)]

      Result.new(data_elements)
    end
  end

  private

  def vessels
    Register::Vessel
      .includes(:current_registration, :latest_discharged_mortgage)
      .where(scrubbable: true)
      .where(scrubbed_at: nil)
      .order(:name)
  end
end
