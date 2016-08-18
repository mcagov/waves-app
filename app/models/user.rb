class User < ApplicationRecord
  include Clearance::User

  has_many :user_roles
  has_many :users, through: :user_roles

  has_many :user_vessel_submissions
  has_many :vessel_submissions, through: :user_vessel_submissions

  def admin?
    false
  end
end
