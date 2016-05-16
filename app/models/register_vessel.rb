class RegisterVessel < ActiveRecord::Base
  belongs_to :register
  belongs_to :vessel
end
