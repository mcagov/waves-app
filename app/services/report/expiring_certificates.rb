class Report::ExpiringCertificates < Report
  def title
    "Expiring Certificates"
  end

  def filter_fields
    [:filter_part, :filter_date_range]
  end

  def headings
    [
      :vessel_name, :certificate, :expiry_date
    ]
  end

  def date_range_label
    "Expiry Date"
  end

  def results
    @pagination_collection = vessels
    @pagination_collection.map do |vessel|
      Result.new(
        [
          RenderAsLinkToVessel.new(vessel, :name), "", ""
        ])
    end
  end

  def vessels
    query = Register::Vessel
    query = filter_by_part(query)
    paginate(query)
  end
end
