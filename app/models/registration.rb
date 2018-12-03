class Registration < ApplicationRecord
  belongs_to :actioned_by, class_name: "User", required: false
  belongs_to :registered_vessel, class_name: "Register::Vessel",
                                 foreign_key: :vessel_id

  has_many :submissions, -> { order("created_at desc") }

  scope :fishing_vessels, (lambda do
    where(
      "(registry_info#>>'{vessel_info, part}' = 'part_2') OR "\
      "(registry_info#>>'{vessel_info, part}' = 'part_4' AND "\
      "registry_info#>>'{vessel_info, registration_type}' = 'fishing')")
  end)

  scope :under_12m, -> { where("#{register_length_finder} < ?", 12.0) }
  scope :over_12m, -> { where("#{register_length_finder} >= ?", 12.0) }

  def self.register_length_finder
    "cast
      (coalesce(nullif(
        (registry_info#>>'{vessel_info, register_length}'), ''), '0')
          as numeric)"
  end

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

  def mortgages
    (symbolized_registry_info[:mortgages] || []).map do |m|
      (m[:mortgagors] || []).map! { |mortgagor| Mortgagor.new(mortgagor) }
      (m[:mortgagees] || []).map! { |mortgagee| Mortgagee.new(mortgagee) }
      Mortgage.new(m) unless m[:discharged_at]
    end.compact
  end

  def charterers
    (symbolized_registry_info[:charterers] || []).map do |charterer|
      charterer[:charter_parties].map! do |charter_party|
        CharterParty.new(charter_party)
      end
      Charterer.new(charterer)
    end
  end

  def delivery_name_and_address
    # Taking the delivery address from the most recent submission
    # is probably not the best approach but, for now, that is
    # what we are going to do
    submission ? submission.delivery_address.name_and_address : []
  end

  def delivery_name
    if submission.try(:delivery_address)
      submission.delivery_address.try(:name) || submission.applicant_name
    end
  end

  def submission_ref_no
    submission.try(:ref_no)
  end

  def applicant_name
    submission.applicant_name if submission
  end

  def shareholder_groups
    (symbolized_registry_info[:shareholder_groups] || [])
  end

  def owner_name_address_shareholding
    arr = owners_and_shares
    arr += shareholder_groups_and_shares
    arr.join("; ")
  end

  def certificate_template
    provisional? ? :provisional_certificate : :registration_certificate
  end

  def task_description
    if submission
      ApplicationType.new(submission.application_type).description
    else
      ""
    end
  end

  private

  def submission
    submissions.first
  end

  def task
    submission ? submission.application_type : :new_registration
  end

  def symbolized_registry_info
    if registry_info.blank?
      {}
    else
      registry_info.deep_symbolize_keys!
    end
  end

  def owners_and_shares
    owners.map do |owner|
      "#{owner.name}, #{owner.inline_address} (#{owner.shares_held} shares)"
    end
  end

  def shareholder_groups_and_shares
    shareholder_groups.map do |shareholder_group|
      next unless shareholder_group[:owners].present?

      sh_group_owners =
        shareholder_group[:owners].map do |owner|
          "#{owner[:name]}, #{owner[:inline_address]}"
        end.join(" jointly with ")

      "#{sh_group_owners} (#{shareholder_group[:shares_held]} shares)"
    end
  end
end
