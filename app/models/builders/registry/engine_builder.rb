class Builders::Registry::EngineBuilder
  class << self
    def create(submission, vessel)
      @submission = submission
      @vessel = vessel

      perform

      @vessel
    end

    private

    def perform
      @vessel.engines.delete_all
      @submission.engines.each do |submission_engine|
        vessel_engine = submission_engine.clone
        vessel_engine.parent = @vessel
        vessel_engine.save
      end
    end
  end
end
