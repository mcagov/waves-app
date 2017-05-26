class Builders::Registry::AgentBuilder
  class << self
    def create(submission, vessel, _approval_params)
      @submission = submission
      @vessel = vessel

      perform

      @vessel.reload
    end

    private

    def perform
      if @submission.agent
        agent = @vessel.agent || @vessel.build_agent
        agent.name = @submission.agent.name
        agent.email = @submission.agent.email
        agent.phone_number = @submission.agent.phone_number
        agent.save
      end
    end
  end
end
