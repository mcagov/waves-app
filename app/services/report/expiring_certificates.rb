class Report::ExpiringCertificates < Report
  def title
    "Expiring Certificates"
  end

  def filter_fields
    [:filter_document_type, :filter_part, :filter_date_range]
  end

  def headings
    [
      :vessel_name, :part, :official_no, :certificate, :expiry_date
    ]
  end

  def date_range_label
    "Expiry Date"
  end

  def results # rubocop:disable Metrics/MethodLength
    @pagination_collection = certificates
    @pagination_collection.map do |certificate|
      vessel = certificate.vessel
      Result.new(
        [
          RenderAsLinkToVessel.new(vessel, :name),
          Activity.new(vessel.part), vessel.reg_no,
          (certificate.entity_type || "").to_s.titleize,
          certificate.expires_at
        ])
    end
  end

  def certificates
    query = VesselCertificate.joins(:vessel)
    query = filter_by_part(query)
    query = filter_by_note_expires_at(query)
    query = filter_by_document_type(query)
    paginate(query.all)
  end

  class VesselCertificate < ApplicationRecord
    self.table_name = "notes"
    self.inheritance_column = :_type_disabled

    belongs_to :vessel, class_name: "Register::Vessel",
                        foreign_key: "noteable_id"

    default_scope do
      where("noteable_type = 'Register::Vessel'")
        .where("entity_type is not null")
        .where("expires_at is not null")
        .includes(:vessel)
        .order(expires_at: :asc)
    end

    scope :in_part, ->(part) { where("vessels.part = ?", part) }
  end
end
