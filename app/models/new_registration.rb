class NewRegistration < Submission
  def job_type
    "New Registration"
  end

  def process_application
    NewRegistration.transaction do
      reg_vessel = Register::Vessel.create(
        {
          name: vessel.name,
          hin: vessel.hin,
          make_and_model: vessel.make_and_model,
          length_in_meters: vessel.length_in_meters,
          number_of_hulls: vessel.number_of_hulls,
          mmsi_number: vessel.mmsi_number,
          radio_call_sign: vessel.radio_call_sign,
          vessel_type: vessel.type_of_vessel
        }
      )

      owners.each do |owner|
        Register::Owner.create(
          vessel_id: reg_vessel.id,
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

      Registration.create(
        vessel_id: reg_vessel.id,
        submission_id: self.id,
        registered_at: Date.today,
        registered_until: Date.today.advance(days: 364)
      )
    end
  end

  protected

  def set_ref_no
    self.ref_no ||= RefNo.generate("3N")
  end
end
