module SubmissionTaskHelper
  def link_to_create_standard_task(service, part)
    submission_task = Submission::Task.new(
      service: service,
      submission: @submission,
      price: service.standard_price(part))

    render partial: "/submission/tasks/new",
           locals: { submission_task: submission_task }
  end

  def link_to_create_premium_task(service, part)
    submission_task = Submission::Task.new(
      service: service,
      submission: @submission,
      price: service.premium_price(part))

    render partial: "/submission/tasks/new",
           locals: { submission_task: submission_task }
  end

  def link_to_create_subsequent_task(service, part)
    submission_task = Submission::Task.new(
      service: service,
      submission: @submission,
      price: service.subsequent_price(part))

    render partial: "/submission/tasks/new",
           locals: { submission_task: submission_task }
  end
end
