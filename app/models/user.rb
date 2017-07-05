class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :trackable, :validatable

  enum access_level:
    [:read_only, :operational_user, :team_leader, :system_manager]

  def to_s
    name
  end
end
