class NewRegistration < Submission
  def job_type
    "New Registration"
  end

  def process_application
    NewRegistration.transaction do
      @reg_vessel = Register::Vessel.create(vessel_params)
      assign_owners
      create_registration
    end
  end

  protected

  def vessel_params
    {
      name: vessel.name,
      hin: vessel.hin,
      make_and_model: vessel.make_and_model,
      length_in_meters: vessel.length_in_meters,
      number_of_hulls: vessel.number_of_hulls,
      mmsi_number: vessel.mmsi_number,
      radio_call_sign: vessel.radio_call_sign,
      vessel_type: vessel.type_of_vessel,
    }
  end

  def assign_owners # rubocop:disable Metrics/MethodLength
    owners.each do |owner|
      Register::Owner.create(
        vessel_id: @reg_vessel.id,
        name: owner.name,
        nationality: owner.nationality,
        email: owner.email,
        phone_number: owner.phone_number,
        address_1: owner.address_1,
        address_2: owner.address_2,
        address_3: owner.address_3,
        town: owner.town,
        county: owner.county,
        postcode: owner.postcode,
        country: owner.country
      )
    end
  end

  def create_registration
    Registration.create(
      vessel_id: @reg_vessel.id,
      submission_id: id,
      registered_at: Date.today,
      registered_until: Date.today.advance(days: 364),
      actioned_by: claimant
    )
  end

  def ref_no_prefix
    "3N"
  end
end
