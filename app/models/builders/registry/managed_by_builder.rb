class Builders::Registry::ManagedByBuilder
  class << self
    def create(submission, vessel, _approval_params)
      @submission = submission
      @vessel = vessel

      perform

      @vessel.reload
    end

    private

    def perform
      @vessel.managed_bys.delete_all
      @submission.managed_bys.each do |submission_managed_by|
        vessel_managed_by =
          ManagedBy.new(
            submission_managed_by.attributes.except!("id"))

        vessel_managed_by.parent = @vessel
        vessel_managed_by.save
      end
    end
  end
end
