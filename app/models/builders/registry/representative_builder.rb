class Builders::Registry::RepresentativeBuilder
  class << self
    def create(submission, vessel)
      @submission = submission
      @vessel = vessel

      perform

      @vessel.reload
    end

    private

    # rubocop:disable all
    def perform
      @vessel.representative.try(:destroy)

      @vessel.create_representative(
        name: @submission.representative.name,
        imo_number: @submission.representative.imo_number,
        eligibility_status: @submission.representative.eligibility_status,
        entity_type: @submission.representative.entity_type,
        nationality: @submission.representative.nationality,
        email: @submission.representative.email,
        phone_number: @submission.representative.phone_number,
        address_1: @submission.representative.address_1,
        address_2: @submission.representative.address_2,
        address_3: @submission.representative.address_3,
        town: @submission.representative.town,
        postcode: @submission.representative.postcode,
        country: @submission.representative.country)
    end
    # rubocop:enable all
  end
end
