class Registration < ApplicationRecord
  belongs_to :vessel, required: false
  belongs_to :delivery_address, class_name: "Address", required: false
  has_one :payment

  validates :task, presence: true

  def submission
    @submission ||= changeset.deep_symbolize_keys!
  end

  def applicant
    @applicant ||= submission[:owners].first
  end

  def vessel_info
    @vessel_info ||= submission[:vessel_info]
  end

  def owners
    @owners ||= submission[:owners]
  end

  def paid?
    payment.present?
  end

  def official_no
    "--pending--"
  end

  def target_date
    "--pending--"
  end

  def source
    "Online"
  end

  def vessel_type
    vessel_info[:vessel_type].present? ? vessel_info[:vessel_type] : vessel_info[:vessel_type_other]
  end
end
