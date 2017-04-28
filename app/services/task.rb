class Task < WavesUtilities::Task
  def new_registration?
    [:new_registration].include?(@key) || provisional_registration?
  end

  def provisional_registration?
    [:provisional].include?(@key)
  end

  def re_registration?
    [:re_registration].include?(@key)
  end
end
