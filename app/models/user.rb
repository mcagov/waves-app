class User < ApplicationRecord
  include Clearance::User

  has_many :user_roles
  has_many :users, through: :user_roles

  def admin?
    false
  end

  def to_s
    name.humanize
  end
end
