class Builders::RegistryBuilder
  class << self
    def create(submission)
      @submission = submission

      Register::Vessel.transaction do
        create_vessel
        assign_vessel
        create_owners
      end
    end

    private

    # rubocop:disable Metrics/AbcSize
    def create_vessel
      # find_or_initialize
      @vessel = Register::Vessel.create(
        part: @submission.part,
        name: @submission.vessel.name,
        hin: @submission.vessel.hin,
        make_and_model: @submission.vessel.make_and_model,
        length_in_meters: @submission.vessel.length_in_meters,
        number_of_hulls: @submission.vessel.number_of_hulls,
        mmsi_number: @submission.vessel.mmsi_number,
        radio_call_sign: @submission.vessel.radio_call_sign,
        vessel_type: @submission.vessel.type_of_vessel)
    end

    def assign_vessel
      @submission.update_attribute(:registered_vessel_id, @vessel.id)
    end

    def create_owners
      # @vessel.owners#delete_all ?

      @submission.owners.each do |owner|
        Register::Owner.create(
          vessel: @vessel,
          name: owner.name, nationality: owner.nationality,
          email: owner.email, phone_number: owner.phone_number,
          address_1: owner.address_1, address_2: owner.address_2,
          town: owner.town, postcode: owner.postcode,
          country: owner.country
        )
      end
    end
  end
end
