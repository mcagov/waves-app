class Register::ShareholderGroup < ApplicationRecord
  belongs_to :vessel

  has_many :shareholder_group_members, dependent: :destroy
  has_many :owners, through: :shareholder_group_members
end
