class Builders::Registry::DirectedByBuilder
  class << self
    def create(submission, vessel, _approval_params)
      @submission = submission
      @vessel = vessel

      perform

      @vessel.reload
    end

    private

    def perform
      @vessel.directed_bys.delete_all
      @submission.directed_bys.each do |submission_directed_by|
        vessel_directed_by =
          DirectedBy.new(
            submission_directed_by.attributes.except!("id"))

        vessel_directed_by.parent = @vessel
        vessel_directed_by.save
      end
    end
  end
end
