module Register
  class Vessel < ApplicationRecord
    protokoll :reg_no, pattern: "SSR2#####"

    has_many :owners, class_name: "Register::Owner"

    has_many :registrations
    has_one :latest_registration,
            -> { order("registered_until desc").limit(1) },
            class_name: "Registration"

    has_many :correspondences, as: :noteable
    has_many :notes,
             -> { where("type is null").order("created_at desc") },
             as: :noteable

    has_many :submissions,
             -> { order("created_at desc") },
             foreign_key: :registered_vessel_id

    def to_s
      name.upcase
    end

    def notification_list
      Builders::NotificationListBuilder.for_registered_vessel(self)
    end

    def registration_status
      return :pending unless latest_registration

      if latest_registration .registered_until >= Date.today
        :registered
      else
        :expired
      end
    end
  end
end
