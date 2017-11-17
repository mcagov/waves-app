class Register::SectionNotice < Note
  def regulation_key
    subject.split(" ").first || "n/a"
  end

  def vessel
    noteable
  end

  def section_notice_date
    created_at
  end

  def termination_notice_date
    updated_at
  end

  def termination_date
    termination_notice_date.advance(days: 7)
  end
end
