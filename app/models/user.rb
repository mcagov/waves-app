class User < ActiveRecord::Base
  include Clearance::User

  has_many :user_roles
  has_many :users, through: :user_roles

  has_many :user_vessel_registrations
  has_many :registrations, through: :user_vessel_registrations
end
