module Register
  class Vessel < ApplicationRecord
    protokoll :reg_no, pattern: "SSR2#####"

    has_many :owners, class_name: "Register::Owner"

    def to_s
      name
    end
  end
end
