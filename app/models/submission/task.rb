class Submission::Task < ApplicationRecord
  belongs_to :service
  belongs_to :submission

  delegate :to_sym, to: :service

  protokoll :submission_ref_counter, scope_by: :submission_id, pattern: "#"

  def ref_no
    "#{submission.ref_no}/#{submission_ref_counter}"
  end
end
