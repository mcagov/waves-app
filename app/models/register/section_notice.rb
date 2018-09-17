class Register::SectionNotice < Note
  has_one :print_job, as: :printable

  def regulation_key
    subject.to_s.split(" ").first || "n/a"
  end

  def vessel
    noteable
  end

  def section_notice_date
    created_at
  end

  def termination_date
    termination_notice_date.advance(days: 7)
  end
end
