class Declaration < ApplicationRecord
  belongs_to :submission, touch: true, required: true
  belongs_to :completed_by, class_name: "User"
  belongs_to :registered_owner, class_name: "Owner"

  validates :submission_id, presence: true

  has_one :notification, as: :notifiable

  include ActiveModel::Transitions

  state_machine auto_scopes: true do
    state :incomplete
    state :completed

    event :declared, timestamp: true do
      transitions to: :completed, from: :incomplete
    end

    event :incomplete do
      transitions to: :incomplete, from: :completed
    end
  end

  attr_accessor :declaration_signed

  scope :individual, -> { where("entity_type = 'individual'") }
  scope :corporate, -> { where("entity_type = 'corporate'") }

  delegate :part, to: :submission

  has_one :owner,
          as: :parent,
          class_name: "Declaration::Owner",
          dependent: :destroy

  # rubocop:disable Style/AlignHash
  accepts_nested_attributes_for :owner, allow_destroy: true,
    reject_if: proc { |attributes| attributes["name"].blank? }

  def owner_email
    owner.email if owner
  end

  def vessel
    submission.vessel
  end

  def other_owners
    (submission.declarations - [self]).map(&:owner)
  end
end
