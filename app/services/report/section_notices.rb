class Report::SectionNotices < Report
  def title
    "Section Notices"
  end

  def headings
    [
      "Name", "Part", "Official No", "Section Notice Issue Date",
      "Section Notice Issue Date + 30", "Regulation Reference",
      "Current Registration Status"
    ]
  end

  def results # rubocop:disable Metrics/MethodLength
    @pagination_collection = section_notices
    @pagination_collection.map do |section_notice|
      vessel = section_notice.vessel
      Result.new(
        [
          RenderAsLinkToVessel.new(vessel, :name),
          Activity.new(vessel.part),
          vessel.reg_no,
          section_notice.created_at,
          date_plus_30(section_notice.created_at),
          section_notice.regulation_key,
          RenderAsRegistrationStatus.new(vessel.registration_status),
        ])
    end
  end

  def section_notices
    query = Register::SectionNotice.includes(:noteable).order(created_at: :desc)
    paginate(query)
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
