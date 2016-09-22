class Builders::RegistrationBuilder
  class << self
    def create(submission)
      @submission = submission

      Registration.transaction do
        create_vessel
        create_owners
        create_registration
      end

      @registration
    end

    private

    def create_vessel
      @vessel = Register::Vessel.create(
        name: @submission.vessel.name,
        hin: @submission.vessel.hin,
        make_and_model: @submission.vessel.make_and_model,
        length_in_meters: @submission.vessel.length_in_meters,
        number_of_hulls: @submission.vessel.number_of_hulls,
        mmsi_number: @submission.vessel.mmsi_number,
        radio_call_sign: @submission.vessel.radio_call_sign,
        vessel_type: @submission.vessel.type_of_vessel
      )
    end

    def create_owners
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

    def create_registration
      @registration = Registration.create(
        vessel: @vessel,
        submission_id: @submission.id,
        registered_at: Date.today,
        registered_until: Date.today.advance(years: 5),
        actioned_by: @submission.claimant
      )
    end
  end
end
