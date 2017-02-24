class Registration < ApplicationRecord
  belongs_to :actioned_by, class_name: "User", required: false
  belongs_to :registered_vessel, class_name: "Register::Vessel",
                                 foreign_key: :vessel_id

  validates :task, presence: true

  def vessel
    symbolized_registry_info[:vessel_info] || {}
  end

  def vessel_name
    vessel[:name] || ""
  end

  def part
    (vessel[:part] || :part_3).to_sym
  end

  def owners
    symbolized_registry_info[:owners] || []
  end

  def engines
    (symbolized_registry_info[:engines] || []).map do |engine|
      Engine.new(engine)
    end
  end

  def delivery_address
    submission = Submission.find_by(ref_no: submission_ref_no)
    if submission && submission.delivery_address.active?
      submission.delivery_address
    else
      Submission::DeliveryAddress.new(owners.first)
    end
  end

  private

  def symbolized_registry_info
    if registry_info.blank?
      {}
    else
      registry_info.deep_symbolize_keys!
    end
  end
end
