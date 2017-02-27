class Register::ShareholderGroupMember < ApplicationRecord
  belongs_to :owner
  belongs_to :shareholder_group

  def owner_key
    "#{owner.name};#{owner.email}"
  end
end
