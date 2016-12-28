class Builders::LinkedSubmissionBuilder
  class << self
    def create(source_submission, target_ref_no)
      @source_submission = source_submission
      return unless @source_submission.officer_intervention_required?

      @target_submission = Submission.find_by(ref_no: target_ref_no)

      process_source_submission if @target_submission

      @target_submission
    end

    private

    def process_source_submission
      @source_submission.payments.each do |payment|
        payment.update_attribute(:submission_id, @target_submission.id)
      end

      @source_submission.destroy
    end
  end
end
