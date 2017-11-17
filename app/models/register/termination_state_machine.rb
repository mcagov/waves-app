module Register::TerminationStateMachine
  class << self
    def included(base) # rubocop:disable Metrics/MethodLength
      base.include ActiveModel::Transitions

      base.state_machine auto_scopes: true do
        state :active
        state :section_notice_issued
        state :termination_notice_issued
        state :terminated

        event :issue_section_notice do
          transitions to: :section_notice_issued,
                      from: :active
        end

        event :issue_termination_notice do
          transitions to: :termination_notice_issued,
                      from: :section_notice_issued
        end

        event :terminate do
          transitions to: :terminated,
                      from: :termination_notice_issued
        end

        event :restore_active_state do
          transitions to: :active,
                      from: [:section_notice_issued,
                             :termination_notice_issued,
                             :terminated]
        end
      end
    end
  end
end
