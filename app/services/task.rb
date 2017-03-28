class Task < WavesUtilities::Task
  def new_registration?
    [:provisional, :new_registration].include?(@key)
  end
end
