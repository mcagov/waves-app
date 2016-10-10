module SubmissionPrintJobs
  extend ActiveSupport::Concern

  included do

    def update_print_jobs(print_job_type)
      print_jobs[print_job_type] = Time.now
      update_attribute(:print_jobs, print_jobs)
    end

    def build_print_jobs
      { registration_certificate: false, cover_letter: false }
    end

    def print_jobs_completed?(_print_job_type)
      false
    end
  end
end
