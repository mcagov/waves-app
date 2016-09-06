class Declaration < ApplicationRecord
  belongs_to :submission
  belongs_to :notification

  include ActiveModel::Transitions

  state_machine auto_scopes: true do
    state :incomplete
    state :completed

    event :declared, timestamp: true, success: :declare_submission do
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

  def owners
    submission.declarations.map(&:owner)
  end

  private

  def declare_submission
    submission.declared!
  end
end
