class Declaration < ApplicationRecord
  belongs_to :submission, touch: true
  belongs_to :completed_by, class_name: "User"
  belongs_to :registered_owner, class_name: "Owner"

  has_one :notification, as: :notifiable

  has_many :declaration_group_members,
           class_name: "Declaration::GroupMember",
           dependent: :destroy

  include ActiveModel::Transitions

  state_machine auto_scopes: true do
    state :incomplete
    state :completed
    state :not_required

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

  # TO DO (used by API)
  # owner.declared_at = completed_at

  # rubocop:disable Style/AlignHash
  accepts_nested_attributes_for :owner, allow_destroy: true,
    reject_if: proc { |attributes| attributes["name"].blank? }

  def vessel
    submission.vessel
  end

  def other_owners
    (submission.declarations - [self]).map(&:owner)
  end
end
