class Registration < ApplicationRecord
  belongs_to :actioned_by, class_name: "User", required: false
  belongs_to :registered_vessel, class_name: "Register::Vessel",
                                 foreign_key: :vessel_id

  has_many :submissions, -> { order("created_at desc") }

  scope :fishing_vessels, (lambda do
    where(
      "(registry_info#>>'{vessel_info, part}' = 'part_2') OR "\
      "(registry_info#>>'{vessel_info, part}' = 'part_2' AND "\
      "registry_info#>>'{vessel_info, registration_type}' = 'fishing')")
  end)

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

  def delivery_name_and_address
    # Taking the delivery address from the most recent submission
    # is probably not the best approach but, for now, that is
    # what we are going to do
    submission ? submission.delivery_address.name_and_address : []
  end

  def applicant_name
    submission.applicant_name if submission
  end

  def shareholder_groups
    (symbolized_registry_info[:shareholder_groups] || [])
  end

  def prints_duplicate_certificate?
    Task.new(task).duplicates_certificate?
  end

  private

  def submission
    submissions.first
  end

  def task
    submission ? submission.task : :new_registration
  end

  def symbolized_registry_info
    if registry_info.blank?
      {}
    else
      registry_info.deep_symbolize_keys!
    end
  end
end
