module Submission::Associations
  def self.included(base)
    base.belongs_to :delivery_address, class_name: "Address", required: false
    base.belongs_to :claimant, class_name: "User", required: false

    base.has_many :payments

    base.has_many :declarations, -> { order("created_at asc") }

    base.has_many :notifications, as: :notifiable
    base.has_many :correspondences, as: :noteable

    base.has_one :cancellation, -> { order("created_at desc").limit(1) },
                 as: :notifiable,
                 class_name: "Notification::Cancellation"

    base.has_one :rejection, -> { order("created_at desc").limit(1) },
                 as: :notifiable,
                 class_name: "Notification::Rejection"

    base.has_one :referral, -> { order("created_at desc").limit(1) },
                 as: :notifiable,
                 class_name: "Notification::Referral"

    base.has_one :application_receipt, -> { order("created_at desc").limit(1) },
                 as: :notifiable,
                 class_name: "Notification::ApplicationReceipt"

    base.has_one :registration
    base.has_one :registered_vessel, through: :registration, source: :vessel

    base.scope :assigned_to, -> (claimant) { where(claimant: claimant) }

    base.scope :referred_until_expired, lambda {
      where("date(referred_until) <= ?", Date.today)
    }
  end
end
