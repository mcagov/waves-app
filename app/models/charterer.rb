class Charterer < ApplicationRecord
  belongs_to :parent, polymorphic: true
  has_many :charterers, dependent: :destroy
end
