module SubmissionTransitions
  extend ActiveSupport::Concern

  included do
    include ActiveModel::Transitions

    state_machine auto_scopes: true do
      state :incomplete, enter: :init_new_submission
      state :unassigned
      state :assigned
      state :referred
      state :printing
      state :completed
      state :rejected
      state :referred
      state :cancelled

      event :paid do
        transitions to: :unassigned, from: :incomplete,
                    on_transition: :init_processing_dates,
                    guard: :unassignable?
      end

      event :declared do
        transitions to: :unassigned, from: :incomplete,
                    on_transition: :init_processing_dates,
                    guard: :unassignable?
      end

      event :claimed do
        transitions to: :assigned,
                    from: [:unassigned, :rejected, :cancelled],
                    on_transition: :add_claimant
      end

      event :unreferred do
        transitions to: :unassigned, from: :referred,
                    on_transition: :init_processing_dates
      end

      event :unclaimed do
        transitions to: :unassigned, from: :assigned,
                    on_transition: :remove_claimant
      end

      event :approved do
        transitions to: :printing, from: :assigned,
                    on_transition: :process_application
      end

      event :printed do
        transitions to: :completed, from: :printing,
                    on_transition: :update_print_jobs,
                    guard: :print_jobs_completed?
      end

      event :cancelled do
        transitions to: :cancelled, from: :assigned,
                    on_transition: :remove_claimant
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
  end
end
