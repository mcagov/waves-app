class RefNo
  class << self
    def generate_for(submission)
      @submission = submission
      build_unique(build_prefix)
    end

    private

    def build_prefix
      task_key = @submission.task.to_sym == :new_registration ? "N" : "X"
      "#{@submission.part[-1]}#{task_key}"
    end

    def build_unique(prefix)
      ref_no = prefix + "-" + SecureRandom.hex(3).upcase
      if Submission.where(ref_no: ref_no).empty?
        ref_no
      else
        build_unique(prefix)
      end
    end
  end
end
