module SubmissionPrintJobs
  extend ActiveSupport::Concern

  included do
    def update_print_job!(print_job_type)
      print_jobs[print_job_type] = Time.now
      update_attribute(:print_jobs, print_jobs)
      printed!
    end

    def build_print_jobs
      print_job_types.inject({}) do |h, print_job_type|
        h.merge(print_job_type => false)
      end
    end

    def print_jobs_completed?
      !print_jobs.map(&:last).include?(false)
    end

    def printed?(print_job_type)
      print_jobs[print_job_type.to_s].present?
    end
  end
end
