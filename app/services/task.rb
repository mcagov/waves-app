class Task < WavesUtilities::Task
  def new_registration?
    [:provisional, :new_registration].include?(@key)
  end

  def display_changeset?
    return false if @key == :re_registration
    builds_registry?
  end
end
