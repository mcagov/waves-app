module Register
  class Vessel < ApplicationRecord
    protokoll :reg_no, pattern: "SSR2#####"

    has_many :owners, class_name: "Register::Owner"

    has_many :registrations
    has_one :latest_registration,
            -> { order("registered_until desc").limit(1) },
            class_name: "Registration"

    def to_s
      name
    end

    def submission_list
      registrations
        .map(&:submission)
        .compact.sort { |a, b| b.created_at <=> a.created_at }
    end
  end
end
