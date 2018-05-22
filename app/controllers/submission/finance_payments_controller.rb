class Submission::FinancePaymentsController < InternalPagesController
  before_action :load_submission_and_finance_payment

  def show
    load_linkable_submission
    @submission = Decorators::Submission.new(@submission)
    @finance_payment = Decorators::FinancePayment.new(@finance_payment)
    @similar_submissions = Search.similar_submissions(@submission)
  end

  def convert
    @submission.officer_intervention_required = false
    @submission.ref_no = RefNo.generate_for(@submission)

    if @submission.save
      process_converted_application
      flash[:notice] = "You have successfully converted that application"
      redirect_to tasks_my_tasks_path
    else
      @submission.officer_intervention_required = true
      render :edit
    end
  end

  def link
    @target_submission =
      Builders::LinkedSubmissionBuilder
      .create(@submission, params[:target_ref_no])

    if @target_submission
      redirect_to @target_submission
    else
      flash[:notice] = "Unknown Application Reference No."
      redirect_to @submission
    end
  end

  def unlink
    @submission.update_attribute(:linkable_ref_no, nil)
    redirect_to submission_path(@submission)
  end

  def edit; end

  def update
    @submission.assign_attributes(submission_params)

    if @submission.save
      redirect_to submission_path(@submission)
    else
      @submission.update_attribute(:officer_intervention_required, true)
      render :edit
    end
  end

  protected

  def load_submission_and_finance_payment
    @submission = Submission.find(params[:submission_id])
    @finance_payment = @submission.payment.try(:remittance)
  end

  def load_linkable_submission
    linkable_ref_no = @submission.linkable_ref_no
    @linkable_submission =
      Submission.find_by(ref_no: linkable_ref_no) if linkable_ref_no
  end

  def submission_params
    params.require(:submission).permit(:vessel_reg_no)
  end

  def process_converted_application
    ensure_vessel_name
    create_notification
    unassign_submission
  end

  def create_notification
    Notification::ApplicationReceipt.create(
      notifiable: @submission,
      recipient_name: @submission.applicant_name,
      recipient_email: @submission.applicant_email,
      actioned_by: current_user)
  end

  def ensure_vessel_name
    unless @submission.vessel.name
      @submission.vessel = { name: @finance_payment.vessel_name }
      @submission.save
    end
  end

  def unassign_submission
    proc(&:to_s)
    @submission.unclaimed!
  end
end
