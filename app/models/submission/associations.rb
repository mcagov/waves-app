module Submission::Associations
  class << self
    def included(base)
      address_associations(base)
      correspondence_associations(base)
      declaration_associations(base)
      notification_associations(base)
      payment_associations(base)
      registration_associations(base)
      user_associations(base)
    end

    def address_associations(base)
      base.belongs_to :delivery_address, class_name: "Address", required: false
    end

    def correspondence_associations(base)
      base.has_many :correspondences, as: :noteable
    end

    def declaration_associations(base)
      base.has_many :declarations, -> { order("created_at asc") }
      base.accepts_nested_attributes_for :declarations, allow_destroy: true
    end

    # rubocop:disable Metrics/MethodLength
    def notification_associations(base)
      base.has_many :notifications, as: :notifiable
      base.has_one :cancellation, -> { order("created_at desc").limit(1) },
                   as: :notifiable,
                   class_name: "Notification::Cancellation"
      base.has_one :rejection, -> { order("created_at desc").limit(1) },
                   as: :notifiable,
                   class_name: "Notification::Rejection"
      base.has_one :referral, -> { order("created_at desc").limit(1) },
                   as: :notifiable,
                   class_name: "Notification::Referral"
      base.has_one :application_receipt,
                   -> { order("created_at desc").limit(1) },
                   as: :notifiable,
                   class_name: "Notification::ApplicationReceipt"
    end

    def payment_associations(base)
      base.has_many :payments
    end

    def registration_associations(base)
      base.has_one :registration
      base.belongs_to :registered_vessel,
                      foreign_key: :vessel_reg_no,
                      class_name: "Register::Vessel"
    end

    def user_associations(base)
      base.belongs_to :claimant, class_name: "User", required: false
      base.scope :assigned_to, -> (claimant) { where(claimant: claimant) }
    end
  end
end
