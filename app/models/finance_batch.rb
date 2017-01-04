class FinanceBatch < ApplicationRecord
  belongs_to :processed_by, class_name: "User"

  protokoll :batch_no, pattern: "1#####"

  def toggle_state!
    closed? ? reopen_batch! : close_batch!
  end

  def closed?
    closed_at.present?
  end

  def close_batch!
    update_attributes(closed_at: Time.now)
  end

  def reopen_batch!
    update_attributes(closed_at: nil)
  end
end
