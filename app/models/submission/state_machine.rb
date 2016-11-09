# rubocop:disable all
module Submission::StateMachine
  class << self
    def included(base)
      base.include ActiveModel::Transitions

      base.state_machine auto_scopes: true do
        state :incomplete, enter: :build_defaults
        state :unassigned
        state :assigned
        state :referred
        state :printing
        state :completed
        state :rejected
        state :referred
        state :cancelled

        event :unassigned do
          transitions to: :unassigned, from: :incomplete,
                      on_transition: :init_processing_dates,
                      guard: :actionable?
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

        event :move_to_print_queue do
          transitions to: :printing, from: :assigned,
                      on_transition: :process_application,
                      guard: :approvable?
        end

        event :completed do
          transitions to: :completed, from: :printing,
                      guard: :printing_completed?
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

        def event_fired(_current_state, _new_state, event)
          self.paper_trail_event = event.name
        end
      end
    end
  end
end
# rubocop:enable all
