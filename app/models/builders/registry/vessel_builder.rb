class Builders::Registry::VesselBuilder
  class << self
    def create(submission)
      @submission = submission

      perform

      @vessel.reload
    end

    private

    def perform
      @vessel = @submission.registered_vessel
      @vessel ||= Register::Vessel.new(part: @submission.part)

      build_summary
      build_identity
      build_operational_info
      build_description
      build_construction

      @vessel.save
    end

    def build_summary
      @vessel.name = @submission.vessel.name
      @vessel.hin = @submission.vessel.hin
      @vessel.make_and_model = @submission.vessel.make_and_model
      @vessel.length_in_meters = @submission.vessel.length_in_meters
      @vessel.number_of_hulls = @submission.vessel.number_of_hulls
      @vessel.mmsi_number = @submission.vessel.mmsi_number
      @vessel.radio_call_sign = @submission.vessel.radio_call_sign
      @vessel.vessel_type = @submission.vessel.type_of_vessel
    end

    def build_identity # extended#Identity section
      @vessel.registration_type = @submission.vessel.registration_type
      @vessel.vessel_category = @submission.vessel.vessel_category
      @vessel.imo_number = @submission.vessel.imo_number
      @vessel.port_code = @submission.vessel.port_code
      @vessel.port_no = @submission.vessel.port_no
      @vessel.ec_number = @submission.vessel.ec_number
      @vessel.last_registry_country = @submission.vessel.last_registry_country
      @vessel.last_registry_no = @submission.vessel.last_registry_no
      @vessel.last_registry_port = @submission.vessel.last_registry_port
    end

    def build_operational_info # extended#Operational Information section
      @vessel.classification_society = @submission.vessel.classification_society
      @vessel.classification_society_other =
        @submission.vessel.classification_society_other
      @vessel.entry_into_service_at = @submission.vessel.entry_into_service_at
      @vessel.area_of_operation = @submission.vessel.area_of_operation
      @vessel.alternative_activity = @submission.vessel.alternative_activity
    end

    def build_description # extended#Description section
      @vessel.gross_tonnage = @submission.vessel.gross_tonnage
      @vessel.net_tonnage = @submission.vessel.net_tonnage
      @vessel.register_tonnage = @submission.vessel.register_tonnage
      @vessel.register_length = @submission.vessel.register_length
      @vessel.length_overall = @submission.vessel.length_overall
      @vessel.breadth = @submission.vessel.breadth
      @vessel.depth = @submission.vessel.depth
      @vessel.propulsion_system = @submission.vessel.propulsion_system
    end

    def build_construction # extended#Construction section
      @vessel.name_of_builder = @submission.vessel.name_of_builder
      @vessel.builders_address = @submission.vessel.builders_address
      @vessel.place_of_build = @submission.vessel.place_of_build
      @vessel.country_of_build = @submission.vessel.country_of_build
      @vessel.keel_laying_date = @submission.vessel.keel_laying_date
      @vessel.hull_construction_material =
        @submission.vessel.hull_construction_material
      @vessel.year_of_build = @submission.vessel.year_of_build
    end
  end
end
