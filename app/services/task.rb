class Task
  def initialize(key)
    @key = key.to_sym
  end

  def description
    Task.manual_entry_task_types.find { |t| t[1] == @key }[0]
  end

  def payment_required?
    ![:change_address, :closure].include?(@key)
  end

  def issues_certificate?
    [
      :new_registration, :change_ownership, :change_vessel, :renew,
      :duplicate_certificate
    ].include?(@key)
  end

  def duplicates_certificate?
    [:duplicate_certificate].include?(@key)
  end

  def renews_certificate?
    [:renewal].include?(@key)
  end

  class << self
    def manual_entry_task_types
      task_types << ["Unknown", :unknown]
    end

    def task_types
      [
        ["Change of Ownership", :change_ownership],
        ["Change of Vessel Details", :change_vessel],
        ["Change of Address", :change_address],
        ["Duplicate Certificate of Registry", :duplicate_certificate],
        ["Name Reservation", :reserve_name],
        ["New Registration", :new_registration],
        ["Registration Renewal", :renewal],
        ["Registration Closure", :closure],
        ["Transcript Request", :transcript]]
    end

    def validation_helper_task_type_list
      task_types.map { |t| t[1].to_s }
    end
  end
end
