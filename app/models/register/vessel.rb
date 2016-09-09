module Register
  class Vessel < ApplicationRecord
    has_many :registered_owners, class_name: "Register::Owner"
  end
end
