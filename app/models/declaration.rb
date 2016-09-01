class Declaration < ApplicationRecord
  belongs_to :submission#, :outstanding_declaration

  include ActiveModel::Transitions

  state_machine auto_scopes: true do
    state :incomplete
    state :completed

    event :declare do
      transitions to: :completed, from: :incomplete
    end
  end
end
