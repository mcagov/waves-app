class Builders::Registry::BeneficialOwnerBuilder
  class << self
    def create(submission, vessel)
      @submission = submission
      @vessel = vessel

      perform

      @vessel.reload
    end

    private

    def perform
      @vessel.beneficial_owners.delete_all
      @submission.beneficial_owners.each do |submission_beneficial_owner|
        vessel_beneficial_owner = submission_beneficial_owner.clone
        vessel_beneficial_owner.parent = @vessel
        vessel_beneficial_owner.save
      end
    end
  end
end
