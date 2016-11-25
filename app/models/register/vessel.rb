module Register
  class Vessel < ApplicationRecord
    protokoll :reg_no, pattern: "SSR2#####"

    validates :part, presence: true

    has_many :owners,
             -> { order("updated_at asc") },
             class_name: "Register::Owner"

    has_many :registrations
    has_one :current_registration,
            -> { order("created_at desc").limit(1) },
            class_name: "Registration"

    has_many :correspondences, as: :noteable
    has_many :notes,
             -> { where("type is null").order("created_at desc") },
             as: :noteable

    has_many :submissions,
             -> { order("created_at desc") },
             foreign_key: :registered_vessel_id

    scope :in_part, ->(part) { where(part: part.to_sym) }

    delegate :registered_until, to: :current_registration

    def to_s
      name.upcase
    end

    def notification_list
      Builders::NotificationListBuilder.for_registered_vessel(self)
    end

    def registration_status
      return :pending unless current_registration

      if registered_until >= Date.today
        :registered
      else
        :expired
      end
    end

    def registry_info
      {
        vessel_info: attributes,
        owners: owners.map(&:attributes),
      }
    end
  end
end
