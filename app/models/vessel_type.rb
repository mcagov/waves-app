class VesselType < ActiveRecord::Base
  belongs_to :vessel

  def self.collected_designations
    VesselType.all.map(&:designation).map(&:titleize)
  end
end
