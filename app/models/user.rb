class User < ApplicationRecord
  include Clearance::User

  has_many :user_roles
  has_many :users, through: :user_roles

  has_many :user_vessel_registrations
  has_many :vessel_registrations, through: :user_vessel_registrations

  def admin?
    false
  end
end
