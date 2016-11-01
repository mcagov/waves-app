class Declaration < ApplicationRecord
  belongs_to :submission
  belongs_to :completed_by, class_name: "User"

  has_one :notification, as: :notifiable

  has_attached_file :completed_form, validate_media_type: false
  do_not_validate_attachment_file_type :completed_form

  include ActiveModel::Transitions

  state_machine auto_scopes: true do
    state :incomplete
    state :completed

    event :declared, timestamp: true, success: :move_submission_to_unassigned do
      transitions to: :completed, from: :incomplete
    end
  end

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

  private

  def move_submission_to_unassigned
    submission.unassigned!
  end
end
