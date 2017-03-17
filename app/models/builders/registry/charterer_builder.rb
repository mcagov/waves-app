class Builders::Registry::ChartererBuilder
  class << self
    def create(submission, vessel)
      @submission = submission
      @vessel = vessel

      perform

      @vessel.reload
    end

    private

    def perform
      @vessel.charterers.delete_all
      @submission.charterers.each do |submission_charterer|
        build_charterer(submission_charterer)
      end
    end

    def build_charterer(submission_charterer)
      vessel_charterer = @vessel.charterers.create(
        reference_number: submission_charterer.reference_number,
        start_date: submission_charterer.start_date,
        end_date: submission_charterer.end_date)

      build_charter_parties_for(vessel_charterer, submission_charterer)
    end

    def build_charter_parties_for(vessel_charterer, submission_charterer)
      submission_charterer.charter_parties.each do |submission_charter_party|
        vessel_charterer.charter_parties.create(
          name: submission_charter_party.name,
          address: submission_charter_party.address,
          contact_details: submission_charter_party.contact_details)
      end
    end
  end
end
