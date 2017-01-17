class Builders::RegistryBuilder
  class << self
    def create(submission)
      @submission = submission

      Register::Vessel.transaction do
        init_vessel
        update_vessel_details
        assign_vessel_to_submission
        build_owners
        build_agent
      end

      @vessel
    end

    private

    def init_vessel
      @vessel = @submission.registered_vessel
      @vessel ||= Register::Vessel.new(part: @submission.part)
    end

    # rubocop:disable all
    def update_vessel_details
      @vessel.name = @submission.vessel.name
      @vessel.hin = @submission.vessel.hin
      @vessel.make_and_model = @submission.vessel.make_and_model
      @vessel.length_in_meters = @submission.vessel.length_in_meters
      @vessel.number_of_hulls = @submission.vessel.number_of_hulls
      @vessel.mmsi_number = @submission.vessel.mmsi_number
      @vessel.radio_call_sign = @submission.vessel.radio_call_sign
      @vessel.vessel_type = @submission.vessel.type_of_vessel
      @vessel.name_approved_until = nil

      # added to support extended#Identity section
      @vessel.registration_type = @submission.vessel.registration_type
      @vessel.vessel_category = @submission.vessel.vessel_category
      @vessel.imo_number = @submission.vessel.imo_number
      @vessel.port_code = @submission.vessel.port_code
      @vessel.port_no = @submission.vessel.port_no
      @vessel.ec_number = @submission.vessel.ec_number
      @vessel.last_registry_country = @submission.vessel.last_registry_country
      @vessel.last_registry_no = @submission.vessel.last_registry_no
      @vessel.last_registry_port = @submission.vessel.last_registry_port

      # added to support extended#Operational Information section
      @vessel.classification_society = @submission.vessel.classification_society
      @vessel.classification_society_other = @submission.vessel.classification_society_other
      @vessel.entry_into_service_at = @submission.vessel.entry_into_service_at
      @vessel.area_of_operation = @submission.vessel.area_of_operation
      @vessel.alternative_activity = @submission.vessel.alternative_activity

      # added to support extended#Description section
      @vessel.gross_tonnage = @submission.vessel.gross_tonnage
      @vessel.net_tonnage = @submission.vessel.net_tonnage
      @vessel.register_tonnage = @submission.vessel.register_tonnage
      @vessel.register_length = @submission.vessel.register_length
      @vessel.length_overall = @submission.vessel.length_overall
      @vessel.breadth = @submission.vessel.breadth
      @vessel.depth = @submission.vessel.depth
      @vessel.propulsion_system = @submission.vessel.propulsion_system

      # added to support extended#Construction section
      @vessel.name_of_builder = @submission.vessel.name_of_builder
      @vessel.builders_address = @submission.vessel.builders_address
      @vessel.place_of_build = @submission.vessel.place_of_build
      @vessel.keel_laying_date = @submission.vessel.keel_laying_date
      @vessel.hull_construction_material = @submission.vessel.hull_construction_material
      @vessel.yard_number = @submission.vessel.yard_number

      @vessel.save
    end
    # rubocop:enable all

    def assign_vessel_to_submission
      unless @submission.registered_vessel
        @submission.update_attribute(:registered_vessel_id, @vessel.id)
      end
    end

    def build_owners
      @vessel.owners.delete_all
      @submission.owners.each { |owner| build_owner(owner) }
    end

    def build_owner(owner) # rubocop:disable Metrics/MethodLength
      @vessel.owners.create(
        name: owner.name, nationality: owner.nationality,
        email: owner.email, phone_number: owner.phone_number,
        address_1: owner.address_1, address_2: owner.address_2,
        address_3: owner.address_3,
        town: owner.town, postcode: owner.postcode,
        country: owner.country,
        imo_number: owner.imo_number,
        eligibility_status: owner.eligibility_status,
        registration_number: owner.registration_number,
        date_of_incorporation: owner.date_of_incorporation)
    end

    def build_agent
      return unless @submission.agent
      agent = @vessel.agent || @vessel.build_agent
      agent.name = @submission.agent.name
      agent.email = @submission.agent.email
      agent.phone_number = @submission.agent.phone_number
      agent.save
    end
  end
end
