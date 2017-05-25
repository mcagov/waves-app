module Register
  class Vessel < ApplicationRecord # rubocop:disable Metrics/ClassLength
    include PgSearch
    multisearchable against:
      [:reg_no, :name, :mmsi_number, :radio_call_sign, :imo_number]

    validates :part, presence: true

    has_one :agent, as: :parent, class_name: "Register::Agent"
    has_many :beneficial_owners, as: :parent, class_name: "BeneficialOwner"
    has_many :directed_bys, as: :parent, class_name: "DirectedBy"
    has_many :customers, as: :parent
    has_one :representative, as: :parent, class_name: "Register::Representative"
    has_many :owners,
             -> { order("updated_at asc") },
             class_name: "Register::Owner",
             as: :parent

    has_many :managers,
             -> { order(:name) },
             class_name: "Manager",
             as: :parent

    has_many :shareholder_groups, dependent: :destroy

    has_many :registrations, -> { order("created_at desc") }
    has_one :current_registration,
            -> { order("created_at desc").limit(1) },
            class_name: "Registration"
    has_one :first_registration,
            -> { order("registered_at asc").limit(1) },
            class_name: "Registration"

    has_many :correspondences, as: :noteable

    has_many :notifications, as: :notifiable

    has_many :documents,
             -> { order("created_at desc") },
             as: :noteable

    has_many :notes,
             -> { where("type is null").order("created_at desc") },
             as: :noteable

    has_many :submissions,
             -> { order("created_at desc") },
             foreign_key: :registered_vessel_id

    has_many :engines, as: :parent

    has_many :charterers, as: :parent
    has_many :charter_parties,
             -> { order("name") },
             through: :charterers

    has_many :mortgages,
             -> { order("priority_code asc") },
             as: :parent

    has_many :csr_forms, -> { order("issue_number desc") }

    scope :in_part, ->(part) { where(part: part.to_sym) }

    delegate :registered_until, to: :current_registration, allow_nil: true

    before_validation :build_reg_no, on: :create

    def correspondent
      Customer.first
    end

    def build_reg_no
      return if reg_no.present?
      self.reg_no = SequenceNumber::Generator.reg_no!(part)
    end

    def to_s
      name.upcase
    end

    def notification_list
      Builders::NotificationListBuilder.for_registered_vessel(self)
    end

    def registration_status
      return :frozen if frozen_at.present?
      return :pending unless current_registration
      return :closed if current_registration.closed_at?
      return :expired if Time.now.to_i > registered_until.to_i
      :registered
    end

    def registry_info # rubocop:disable Metrics/MethodLength
      {
        vessel_info: attributes,
        owners: owners.map(&:attributes),
        agent: (agent || Register::Agent.new).attributes,
        shareholder_groups: shareholder_groups_info,
        engines: engines.map(&:attributes),
        managers: managers_info,
        mortgages: mortgages_info,
        charterers: charterers_info,
        beneficial_owners: beneficial_owners.map(&:attributes),
        directed_bys: directed_bys.map(&:attributes),
        representative: representative_info,
      }
    end

    def prints_registration_certificate?
      registration_status == :registered
    end

    def prints_transcript?
      registration_status != :pending
    end

    def ec_number=(_unimplemented)
      # here we handle legacy changesets with ec_number assigned
    end

    private

    def shareholder_groups_info
      shareholder_groups.map do |sharedholder_group|
        {
          owners: sharedholder_group.owners.map(&:details),
          group_member_keys: sharedholder_group.group_member_keys,
          shares_held: sharedholder_group.shares_held,
        }
      end
    end

    def managers_info
      managers.map do |manager|
        manager.attributes.merge(
          safety_management: manager.safety_management.try(:attributes))
      end
    end

    def mortgages_info
      mortgages.map do |mortgage|
        mortgage.attributes.merge(
          mortgagors: mortgage.mortgagors.map(&:attributes),
          mortgagees: mortgage.mortgagees.map(&:attributes))
      end
    end

    def charterers_info
      charterers.map do |charterer|
        charterer.attributes.merge(
          charter_parties: charterer.charter_parties.map(&:attributes))
      end
    end

    def representative_info
      (representative || Register::Representative.new).attributes
    end
  end
end
