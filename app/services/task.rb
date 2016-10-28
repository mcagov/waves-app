class Task
  class << self
    def description(key)
      manual_entry_task_types.find { |t| t[1] == key.to_sym }[0]
    end

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
