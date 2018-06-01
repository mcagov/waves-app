class Builders::Registry::OwnerBuilder
  class << self
    def create(submission, vessel, _approval_params)
      @submission = submission
      @vessel = vessel

      perform

      @vessel.reload
    end

    private

    def perform
      @vessel.owners.delete_all
      @submission.declarations.each { |declaration| build_owner(declaration) }
    end

    # rubocop:disable all
    def build_owner(declaration)
      owner = declaration.owner
      registered_owner = @vessel.owners.create(
        name: owner.name,
        nationality: owner.nationality,
        email: owner.email,
        phone_number: owner.phone_number,
        address_1: owner.address_1,
        address_2: owner.address_2,
        address_3: owner.address_3,
        town: owner.town,
        postcode: owner.postcode,
        country: owner.country,
        alt_address_1: owner.alt_address_1,
        alt_address_2: owner.alt_address_2,
        alt_address_3: owner.alt_address_3,
        alt_town: owner.alt_town,
        alt_postcode: owner.alt_postcode,
        alt_country: owner.alt_country,
        imo_number: owner.imo_number,
        eligibility_status: owner.eligibility_status,
        registration_number: owner.registration_number,
        date_of_incorporation: owner.date_of_incorporation,
        managing_owner: @submission.managing_owner_id == owner.id,
        correspondent: @submission.correspondent_id == owner.id,
        entity_type: declaration.entity_type,
        shares_held: declaration.shares_held)

      declaration.update_attribute(
        :registered_owner_id, registered_owner.id)
    end
    # rubocop:enable all
  end
end
