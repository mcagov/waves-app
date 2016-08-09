class Registration < ApplicationRecord
  belongs_to :vessel, required: false

  belongs_to :delivery_address, class_name: "Address", required: false

  validates :status, presence: true

  def submission
    @submission ||= changeset.deep_symbolize_keys!
  end

  def correspondent
    @correspondent ||= submission[:owners].first
  end

  def vessel_info
    @vessel_info ||= submission[:vessel_info]
  end

  def owners
    @owners ||= submission[:owners]
  end
end
