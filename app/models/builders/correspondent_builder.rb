class Builders::CorrespondentBuilder
  class << self
    def create(submission, correspondent_id)
      submission.update(correspondent_id: correspondent_id)

      unless submission.delivery_address.active?
        submission.delivery_address = submission.correspondent
        submission.save!
      end
      submission
    end
  end
end
