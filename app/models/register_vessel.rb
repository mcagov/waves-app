class RegisterVessel < ApplicationRecord
  belongs_to :register
  belongs_to :vessel
end
