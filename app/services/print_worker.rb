class PrintWorker
  def initialize(submission)
    @submission = submission
  end

  def update_job!(print_job_type)
    print_jobs = @submission.print_jobs
    print_jobs[print_job_type] = Time.now
    @submission.update_attribute(:print_jobs, print_jobs)
    @submission.completed!
  end
end
