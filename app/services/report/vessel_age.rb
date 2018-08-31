class Report::VesselAge < Report
  def title
    "Vessel Age"
  end

  def xls_title
    "Vessel Age: #{Time.zone.today}"
  end

  def sub_report
    :vessel_age_by_category
  end

  def filter_fields
    [:filter_part]
  end

  def headings
    ["Vessel Category", "Registered", "Average Age", "Gross Tonnage"]
  end

  def results
    load_results.all.map do |result|
      data_elements =
        [
          result.vessel_category,
          result.num_reg,
          result.age.to_f.round(2),
          result.gt]

      Result.new(data_elements, vessel_category: result.vessel_category)
    end
  end

  private

  def load_results
    query = load_select
    query = filter_by_part(query)
    query.group(:vessel_category).order(:vessel_category)
  end

  def load_select
    Register::Vessel
      .select(
        "vessel_category, COUNT(*) num_reg,
        avg(coalesce(now()::DATE - keel_laying_date::DATE, 0)::FLOAT / 365) age,
        sum(gross_tonnage) as gt")
      .where("vessel_category <> ''")
  end
end
