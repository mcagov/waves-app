class Builders::Registry::AgentBuilder
  class << self
    def create(submission, vessel, _approval_params)
      @submission = submission
      @vessel = vessel

      perform

      @vessel.reload
    end

    private

    def perform # rubocop:disable all
      if @submission.agent
        agent = @vessel.agent || @vessel.build_agent
        agent.name = @submission.agent.name
        agent.email = @submission.agent.email
        agent.phone_number = @submission.agent.phone_number
        agent.address_1 = @submission.agent.address_1
        agent.address_2 = @submission.agent.address_2
        agent.address_3 = @submission.agent.address_3
        agent.town = @submission.agent.town
        agent.postcode = @submission.agent.postcode
        agent.country = @submission.agent.country
        agent.save
      end
    end
  end
end
