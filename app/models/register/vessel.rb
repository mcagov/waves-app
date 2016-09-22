module Register
  class Vessel < ApplicationRecord
    has_many :owners, class_name: "Register::Owner"
  end
end
