module SubmissionTransitions
  extend ActiveSupport::Concern

  included do
    include ActiveModel::Transitions

    state_machine auto_scopes: true do
      state :incomplete, enter: :init_new_submission
      state :unassigned
      state :assigned
      state :referred
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
        transitions to: :completed, from: :assigned
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

    protected

    def init_new_submission
      build_ref_no
    end

    def build_ref_no
      self.ref_no = RefNo.generate(ref_no_prefix)
    end

    def build_declarations
      DeclarationBuilder.build(
        self,
        user_input[:owners],
        user_input[:declarations]
      )
    end

    def remove_claimant
      update_attribute(:claimant, nil)
    end

    def add_claimant(user)
      update_attribute(:claimant, user)
    end

    def init_processing_dates
      update_attribute(:received_at, Date.today)

      if payment.wp_amount.to_i == 7500
        update_attribute(:target_date, 5.days.from_now)
        update_attribute(:is_urgent, true)
      else
        update_attribute(:target_date, 20.days.from_now)
      end

      update_attribute(:referred_until, nil)
    end

    def unassignable?
      declarations.incomplete.empty? && payment.present?
    end
  end
end
