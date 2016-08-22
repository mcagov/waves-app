class NewRegistration < Submission
  def job_type
    "New Registration"
  end

  def process_application!
    Register::Vessel.create!(
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
  end
end
