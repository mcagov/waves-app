class Register::SectionNotice < Note
  def regulation_key
    subject.split(" ").first || "n/a"
  end

  def vessel
    noteable
  end
end
