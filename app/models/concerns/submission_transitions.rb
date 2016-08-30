module SubmissionTransitions
  extend ActiveSupport::Concern

  included do
    include ActiveModel::Transitions

    state_machine auto_scopes: true do
      state :incomplete
      state :unassigned
      state :assigned
      state :referred
      state :completed
      state :rejected
      state :referred

      event :paid do
        transitions to: :unassigned, from: :incomplete,
          on_transition: :set_target_date_and_urgent_flag
      end

      event :claimed do
        transitions to: :assigned, from: [:unassigned, :rejected, :referred]
      end

      event :unclaimed do
        transitions to: :unassigned, from: :assigned,
          on_transition: :remove_claimant
      end

      event :approved do
        transitions to: :completed, from: :assigned
      end

      event :rejected do
        transitions to: :rejected, from: :assigned,
          on_transition: :remove_claimant
      end

      event :referred do
        transitions to: :referred, from: :assigned,
          on_transition: :remove_claimant
      end
    end

    private

    def remove_claimant
      update_attribute(:claimant, nil)
    end

    def set_target_date_and_urgent_flag
      if paid? && payment.wp_amount.to_i == 7500
        update_attribute(:target_date, 5.days.from_now)
        update_attribute(:is_urgent, true)
      else
        update_attribute(:target_date, 20.days.from_now)
      end
    end
  end
end