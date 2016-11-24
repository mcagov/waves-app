class Builders::RegistryBuilder
  class << self
    def create(submission)
      @submission = submission

      Register::Vessel.transaction do
        init_vessel
        update_vessel_details
        assign_vessel_to_submission
        build_owners
      end

      @vessel
    end

    private

    def init_vessel
      @vessel = @submission.registered_vessel
      @vessel ||= Register::Vessel.new(part: @submission.part)
    end

    def update_vessel_details
      @vessel.name = @submission.vessel.name
      @vessel.hin = @submission.vessel.hin
      @vessel.make_and_model = @submission.vessel.make_and_model
      @vessel.length_in_meters = @submission.vessel.length_in_meters
      @vessel.number_of_hulls = @submission.vessel.number_of_hulls
      @vessel.mmsi_number = @submission.vessel.mmsi_number
      @vessel.radio_call_sign = @submission.vessel.radio_call_sign
      @vessel.vessel_type = @submission.vessel.type_of_vessel
      @vessel.save
    end

    def assign_vessel_to_submission
      unless @submission.registered_vessel
        @submission.update_attribute(:registered_vessel_id, @vessel.id)
      end
    end

    def build_owners
      @vessel.owners.delete_all
      @submission.owners.each { |owner| build_owner(owner) }
    end

    def build_owner(owner)
      Register::Owner.create(
        vessel: @vessel,
        name: owner.name, nationality: owner.nationality,
        email: owner.email, phone_number: owner.phone_number,
        address_1: owner.address_1, address_2: owner.address_2,
        address_3: owner.address_3,
        town: owner.town, postcode: owner.postcode,
        country: owner.country)
    end
  end
end
