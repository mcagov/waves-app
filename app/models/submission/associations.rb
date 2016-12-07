module Submission::Associations
  class << self
    def included(base)
      address_associations(base)
      notes_associations(base)
      declaration_associations(base)
      misc_associations(base)
      notification_associations(base)
      payment_associations(base)
      registration_associations(base)
      user_associations(base)
    end

    def address_associations(base)
      base.belongs_to :delivery_address, class_name: "Address", required: false
    end

    def notes_associations(base)
      base.has_many :correspondences, as: :noteable
      base.has_many :documents, as: :noteable
    end

    def declaration_associations(base)
      base.has_many :declarations, -> { order("created_at asc") }
      base.has_many :incomplete_declarations, lambda {
        where("state = 'incomplete'")
          .order("created_at asc")
      },
                    class_name: "Declaration"
      base.accepts_nested_attributes_for :declarations, allow_destroy: true
    end

    def misc_associations(base)
      base.has_many :work_logs
    end

    # rubocop:disable Metrics/MethodLength
    def notification_associations(base)
      base.has_many :notifications, as: :notifiable
      base.has_one :cancellation, -> { order("created_at desc").limit(1) },
                   as: :notifiable,
                   class_name: "Notification::Cancellation"
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
      base.belongs_to :registered_vessel,
                      lambda { |submission|
                        where("vessels.part = ?", submission.part)
                      },
                      foreign_key: :registered_vessel_id,
                      class_name: "Register::Vessel"
    end

    def user_associations(base)
      base.belongs_to :claimant, class_name: "User", required: false
      base.scope :assigned_to, -> (claimant) { where(claimant: claimant) }
    end
  end

  def owners
    declarations.map(&:owner)
  end

  def vessel
    Submission::Vessel.new(symbolized_changeset[:vessel_info] || {})
  end

  def agent
    Submission::Agent.new(symbolized_changeset[:agent] || {})
  end

  def vessel=(vessel_params)
    self.changeset ||= {}
    changeset[:vessel_info] = vessel_params
  end

  def delivery_address
    Submission::DeliveryAddress.new(
      symbolized_changeset[:delivery_address] || {})
  end

  def delivery_address=(delivery_address_params)
    changeset[:delivery_address] = delivery_address_params
  end
end
