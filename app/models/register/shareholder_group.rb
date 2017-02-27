class Register::ShareholderGroup < ApplicationRecord
  belongs_to :vessel

  has_many :shareholder_group_members, dependent: :destroy
  has_many :owners, through: :shareholder_group_members

  def group_member_keys
    shareholder_group_members.map(&:owner_key)
  end
end
