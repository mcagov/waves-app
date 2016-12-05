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
      return :frozen if frozen_at.present?
      return :pending unless current_registration
      return :closed if current_registration.closed_at?
      return :expired if Time.now.to_i > registered_until.to_i
      :registered
    end

    def registry_info
      {
        vessel_info: attributes,
        owners: owners.map(&:attributes),
      }
    end

    def prints_registration_certificate?
      registration_status == :registered
    end

    def prints_transcript?
      registration_status != :pending
    end
  end
end
