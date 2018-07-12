module SubmissionTaskHelper
  def link_to_create_standard_task(service, part)
    price = service.standard_price(part)
    link_to_create_task(service, price)
  end

  def link_to_create_premium_task(service, part)
    price = service.premium_price(part)
    link_to_create_task(service, price)
  end

  def link_to_create_subsequent_task(service, part)
    price = service.subsequent_price(part)
    link_to_create_task(service, price)
  end

  def link_to_create_task(service, price)
    return "n/a" unless price

    submission_task = Submission::Task.new(
      service: service,
      submission: @submission,
      price: price)

    render partial: "/submission/tasks/new",
           locals: { submission_task: submission_task }
  end
end
