class Register::SectionNotice < Note
  def regulation_key
    subject.split(" ").first
  end
end
