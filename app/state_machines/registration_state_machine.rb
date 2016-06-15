class RegistrationStateMachine < StrictMachine::Base
  strict_machine do
    state :initiated do
      on :added_vessel_info => :vessel_info_added, if: :valid?
    end
    state :vessel_info_added do
      on :accepted_declaration => :declaration_accepted, if: :valid?
    end
    state :declaration_accepted
  end
end
