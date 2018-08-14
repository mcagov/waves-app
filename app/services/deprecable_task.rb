class DeprecableTask < WavesUtilities::Task
  def provisional_registration?
    [:provisional].include?(@key)
  end

  def mortgages?
    [:mortgage, :mortgage_other].include?(@key)
  end

  class << self
    def flag_in
      [:new_registration, :provisional]
    end

    def flag_out
      [:closure, :registrar_closure, :termination_notice]
    end
  end
end
