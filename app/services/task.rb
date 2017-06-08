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

  def validates_on_approval?
    ![
      :issue_csr, :closure, :current_transcript, :historic_transcript
    ].include?(@key)
  end

  def prevented_from_editing?
    [:closure, :current_transcript, :historic_transcript].include?(@key)
  end
end
