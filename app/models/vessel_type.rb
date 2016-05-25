class VesselType < ActiveRecord::Base
  belongs_to :vessel

  def self.collected_designations
    other_vessel_type = VesselType.find_by(designation: "other")

    vessels =
      VesselType.all.each_with_object([]) do |vessel_type, memo|
      next if vessel_type.id == other_vessel_type.id

      memo << [vessel_type.designation.titleize, vessel_type.id]
    end

    vessels << [("&#8212;"*10).html_safe, {disabled: true, }]
    vessels << ["Other (please specify)", other_vessel_type.id, {"data-target" => "other-vessel-type"}]
  end
end
