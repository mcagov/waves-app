class Builders::Registry::BeneficialOwnerBuilder
  class << self
    def create(submission, vessel, _approval_params)
      @submission = submission
      @vessel = vessel

      perform

      @vessel.reload
    end

    private

    def perform
      @vessel.beneficial_owners.delete_all
      @submission.beneficial_owners.each do |submission_beneficial_owner|
        vessel_beneficial_owner =
          BeneficialOwner.new(
            submission_beneficial_owner.attributes.except!("id"))

        vessel_beneficial_owner.parent = @vessel
        vessel_beneficial_owner.save
      end
    end
  end
end
