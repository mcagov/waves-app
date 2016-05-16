class User < ActiveRecord::Base
  has_many :user_roles
  has_many :users, through: :user_roles

  has_many :user_vessel_registrations
  has_many :vessel_registrations, through: :user_vessel_registrations
end
