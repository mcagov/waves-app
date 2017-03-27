class CharterParty < ApplicationRecord
  belongs_to :charterer

  scope :incomplete, -> { where(declaration_signed: false) }
end
