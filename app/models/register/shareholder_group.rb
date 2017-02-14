class Register::ShareholderGroup < ApplicationRecord
  belongs_to :vessel

  has_many :shareholder_group_members, dependent: :destroy
  has_many :owners, through: :shareholder_group_members

  def group_member_emails
    shareholder_group_members.map do |shareholder_group_member|
      shareholder_group_member.owner.email
    end
  end
end
