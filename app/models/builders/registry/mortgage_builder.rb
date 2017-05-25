class Builders::Registry::MortgageBuilder
  class << self
    def create(submission, vessel)
      @submission = submission
      @vessel = vessel

      perform

      @vessel.reload
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
        priority_code: submission_mortgage.priority_code,
        mortgage_type: submission_mortgage.mortgage_type,
        reference_number: submission_mortgage.reference_number,
        executed_at: submission_mortgage.executed_at,
        registered_at: submission_mortgage.registered_at,
        discharged_at: submission_mortgage.discharged_at,
        amount: submission_mortgage.amount)

      build_mortgagors_for(vessel_mortgage, submission_mortgage)
      build_mortgagees_for(vessel_mortgage, submission_mortgage)
    end

    def build_mortgagors_for(vessel_mortgage, submission_mortgage)
      submission_mortgage.mortgagors.each do |submission_mortgagor|
        mortgagor = Mortgagor.new(submission_mortgagor.attributes.except("id"))
        mortgagor.parent = vessel_mortgage
        mortgagor.save
      end
    end

    def build_mortgagees_for(vessel_mortgage, submission_mortgage)
      submission_mortgage.mortgagees.each do |submission_mortgagee|
        mortgagee = Mortgagee.new(submission_mortgagee.attributes.except("id"))
        mortgagee.parent = vessel_mortgage
        mortgagee.save
      end
    end
  end
end
