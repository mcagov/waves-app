class Declaration < ApplicationRecord
  belongs_to :submission
  belongs_to :notification

  include ActiveModel::Transitions

  state_machine auto_scopes: true do
    state :incomplete
    state :completed

    event :declare, timestamp: true do
      transitions to: :completed, from: :incomplete
    end
  end

  def owner
    owner = Declaration::Owner.new(changeset)
    owner.declared_at = completed_at
    owner
  end

  def vessel
    submission.vessel
  end

  def other_owners
    (submission.declarations - [self]).map(&:owner)
  end
end
