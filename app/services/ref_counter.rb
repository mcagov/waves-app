class RefCounter
  class << self
    def next(submission_task)
      (submission_task
        .submission
        .tasks
        .maximum(:submission_ref_counter) || 0) + 1
    end
  end
end
