class Builders::Registry::MortgageBuilder
  class << self
    def create(submission, vessel)
      @submission = submission
      @vessel = vessel

      perform

      @vessel
    end

    private

    def perform
      @vessel.mortgages.delete_all
      @submission.mortgages.each do |submission_mortgage|
        build_mortgage(submission_mortgage)
      end
    end

    def build_mortgage(submission_mortgage)
      vessel_mortgage = @vessel.mortgages.create(
        mortgage_type: submission_mortgage.mortgage_type,
        reference_number: submission_mortgage.reference_number,
        start_date: submission_mortgage.start_date,
        end_date: submission_mortgage.end_date,
        amount: submission_mortgage.amount,
        mortgagor: submission_mortgage.mortgagor)

      build_mortgagees_for(vessel_mortgage, submission_mortgage)
    end

    def build_mortgagees_for(vessel_mortgage, submission_mortgage)
      submission_mortgage.mortgagees.each do |submission_mortgagee|
        vessel_mortgage.mortgagees.create(
          name: submission_mortgagee.name,
          address: submission_mortgagee.address,
          contact_details: submission_mortgagee.contact_details)
      end
    end
  end
end
