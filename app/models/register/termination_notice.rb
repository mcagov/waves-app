class Register::TerminationNotice < Note
  has_one :print_job, as: :printable

  def regulation_key
    subject.to_s.split(" ").first || "n/a"
  end

  def vessel
    noteable
  end

  def termination_date
    created_at.advance(days: 7)
  end

  def related_section_notice
    vessel.section_notices.where("created_at < ?", created_at).first
  end
end
