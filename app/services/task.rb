class Task
  TASK_TYPES = [
    ["Change of Ownership", :change_ownership],
    ["Change of Vessel Details", :change_vessel],
    ["Change of Address", :change_address],
    ["Duplicate Certificate of Registry", :duplicate_certificate],
    ["Name Reservation", :reserve_name],
    ["New Registration", :new_registration],
    ["Registration Renewal", :renewal],
    ["Registration Closure", :closure],
    ["Transcript Request", :transcript],
    ["Unknown", :unknown],
  ].freeze
end
