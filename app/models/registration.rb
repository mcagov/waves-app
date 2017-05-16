class Registration < ApplicationRecord
  belongs_to :actioned_by, class_name: "User", required: false
  belongs_to :registered_vessel, class_name: "Register::Vessel",
                                 foreign_key: :vessel_id

  has_many :submissions, -> { order("created_at desc") }

  def vessel
    Register::Vessel.new(symbolized_registry_info[:vessel_info] || {})
  end

  def vessel_name
    vessel.name
  end

  def part
    (vessel[:part] || :part_3).to_sym
  end

  def owners
    (symbolized_registry_info[:owners] || []).map do |owner|
      Register::Owner.new(owner)
    end
  end

  def engines
    (symbolized_registry_info[:engines] || []).map do |engine|
      Engine.new(engine)
    end
  end

  def delivery_address
    # Taking the delivery address from the most recent submission
    # is probably not the best approach but, for now, that is
    # what we are going to do
    submission = submissions.first
    if submission && submission.delivery_address.active?
      submission.delivery_address
    else
      Submission::DeliveryAddress.new(owners.first.attributes)
    end
  end

  def correspondent
    # Assuming that the first owner is the correspondent is incorrect.
    # This is a placeholder until we can answer the question:
    # "Who is the correspondent?"
    owners.first
  end

  def shareholder_groups
    (symbolized_registry_info[:shareholder_groups] || [])
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
