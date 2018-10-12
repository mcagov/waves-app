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
      case correspondent_key
      when :agent then @changeset[:agent]
      when :customer then @changeset[:customer]
      else
        load_owner
      end
    end

    def correspondent_key
      (@changeset[:correspondent] || :owners_1).to_sym
    end

    def load_owner
      (@changeset[:owners] || []).detect do |owner|
        owner[:id].to_sym == correspondent_key
      end
    end
  end
end
