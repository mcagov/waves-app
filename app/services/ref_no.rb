class RefNo
  class << self
    def generate_for(submission)
      build_unique unless submission.officer_intervention_required?
    end

    private

    def build_unique
      ref_no = SecureRandom.hex(3).upcase
      if Submission.where(ref_no: ref_no).empty?
        ref_no
      else
        build_unique
      end
    end
  end
end
