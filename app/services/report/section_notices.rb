class Report::SectionNotices < Report
  def title
    "Section Notices"
  end

  def headings
    [
      "Name", "Part", "Official No", "Section Notice Issue Date",
      "Section Notice Issue Date + 30", "Regulation Reference",
      "Termination Notice Issue Date", "Status"
    ]
  end

  def results # rubocop:disable Metrics/MethodLength
    @pagination_collection = vessels
    @pagination_collection.map do |vessel|
      section_notice = vessel.section_notices.first
      section_notice ||= Register::SectionNotice.new

      Result.new(
        [
          RenderAsLinkToVessel.new(vessel, :name),
          Activity.new(vessel.part),
          vessel.reg_no,
          section_notice.created_at,
          date_plus_30(section_notice.created_at),
          section_notice.regulation_key,
          termination_issue_date(section_notice, vessel),
          RenderAsRegistrationStatus.new(vessel.registration_status),
        ])
    end
  end

  def vessels
    query = Register::Vessel.frozen
    query = query.where(
      "state in (?)", %w(section_notice_issued termination_notice_issued))
    paginate(query.includes(:section_notices).order(:name))
  end

  private

  def date_plus_30(the_date)
    the_date.advance(days: 30) if the_date
  end

  def termination_issue_date(section_notice, vessel)
    if vessel.termination_notice_issued?
      section_notice.updated_at
    else
      "n/a"
    end
  end
end
