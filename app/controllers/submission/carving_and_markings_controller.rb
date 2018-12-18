class Submission::CarvingAndMarkingsController < InternalPagesController
  before_action :load_submission
  before_action :load_task

  def new
    @submission = Decorators::Submission.new(@submission)
    @carving_and_marking =
      CarvingAndMarking.new(
        delivery_method: params[:delivery_method] || :print)

    respond_to do |format|
      format.js { render :new }
    end
  end

  def create
    assign_carving_and_marking

    if @carving_and_marking.emailable? && recipients.empty?
      flash[:warning] = "Recipient(s) must be selected"
    elsif @carving_and_marking.save
      Builders::CarvingAndMarkingBuilder.build(
        @carving_and_marking, recipients)
      flash[:notice] = "Carving and Marking Note has been issued"
      log_work!(@task, @task, :carving_and_marking_issued)
    end

    redirect_to submission_task_path(@submission, @task)
  end

  def update_state
    if @submission.carving_and_marking_received_at
      @submission.update_attribute(
        :carving_and_marking_received_at, nil)
    else
      @submission.update_attribute(
        :carving_and_marking_received_at, Time.zone.now)
    end

    render_update_js
  end

  protected

  def assign_carving_and_marking
    @carving_and_marking = CarvingAndMarking.new(carving_and_marking_params)
    @carving_and_marking.submission = @submission
    @carving_and_marking.actioned_by = current_user
  end

  def carving_and_marking_params
    params.require(:carving_and_marking)
          .permit(:delivery_method, :template, :email_subject, :email_body)
  end

  def recipients
    @recipients ||= (params[:recipients] || []).map do |recipient|
      Customer.new(email_description: recipient)
    end
  end

  def render_update_js # rubocop:disable Metrics/MethodLength
    respond_to do |format|
      format.html do
        flash[:notice] = "Carving & Marking Note has been marked as received"
        redirect_to submission_path(@submission)
      end
      format.js do
        @modal_id = params[:modal_id]
        @submission = Decorators::Submission.new(@submission)
        render :update
      end
    end
  end
end
