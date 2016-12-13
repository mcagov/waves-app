class Builders::ApplicantBuilder
  class << self
    def build(submission)
      @submission = submission
      @changeset = @submission.symbolized_changeset
      @correspondent = load_correspondent if @changeset

      if @correspondent
        @submission.applicant_name = @correspondent[:name]
        @submission.applicant_email = @correspondent[:email]
      end

      @submission
    end

    private

    def load_correspondent
      correspondent_key == :agent ? load_agent : load_owner
    end

    def correspondent_key
      (@changeset[:correspondent] || :owners_1).to_sym
    end

    def load_agent
      if @changeset[:agent].present?
        @changeset[:agent]
      else
        @submission.registered_vessel.agent
      end
    end

    def load_owners
      @changeset[:owners] || []
    end

    def load_owner
      load_owners.select do |owner|
        owner[:id].to_sym == correspondent_key
      end.first
    end
  end
end
