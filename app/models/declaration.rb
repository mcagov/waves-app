class Declaration < ApplicationRecord
  belongs_to :submission, touch: true
  belongs_to :completed_by, class_name: "User"

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
  end

  attr_accessor :declaration_signed

  scope :individual, -> { where("entity_type = 'individual'") }
  scope :corporate, -> { where("entity_type = 'corporate'") }

  def owner
    owner = Declaration::Owner.new(changeset || {})
    owner.declared_at = completed_at
    owner
  end

  def owner=(owner_params)
    self.changeset = owner_params
  end

  def vessel
    submission.vessel
  end

  def other_owners
    (submission.declarations - [self]).map(&:owner)
  end
end
