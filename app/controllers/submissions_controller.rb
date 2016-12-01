class SubmissionsController < InternalPagesController
  before_action :load_submission,
                only: [:show, :edit, :update]
  before_action :check_officer_intervention_required,
                only: [:show, :edit, :update]

  def new
    @submission =
      Submission.new(received_at: Date.today, part: current_activity.part)
  end

  def create
    init_new_submission

    if @submission.save
      send_application_receipt_email

      redirect_to submission_path(@submission)
    else
      render :new
    end
  end

  def show
    @submission = Decorators::Submission.new(@submission)
  end

  def edit; end

  def update
    if @submission.update_attributes(submission_params)
      flash[:notice] = "The application has been updated"
      redirect_to submission_path(@submission)
    else
      render :edit
    end
  end

  protected

  def load_submission
    @submission =
      Submission.in_part(current_activity.part).includes(
        [
          { payments: [:remittance] },
          { declarations: [:notification] },
          :incomplete_declarations,
          :correspondences,
          :notifications,
          :work_logs]).find(params[:id])
  end

  # rubocop:disable Metrics/MethodLength
  def submission_params
    params.require(:submission).permit(
      :part, :task, :received_at, :applicant_name,
      :applicant_email, :vessel_reg_no,
      vessel: [
        :name, :hin, :make_and_model, :length_in_meters, :number_of_hulls,
        :vessel_type, :vessel_type_other, :mmsi_number, :radio_call_sign],
      declarations_attributes: [
        :id,
        :_destroy,
        owner: [:name, :email, :phone_number, :nationality, :address_1,
                :address_2, :address_3, :town, :postcode],
      ]
    )
  end

  def check_officer_intervention_required
    if @submission.officer_intervention_required?
      return redirect_to submission_finance_payment_path(@submission)
    end
  end

  def send_application_receipt_email
    return unless params[:new_submission_actions] == "application_receipt"

    Notification::ApplicationReceipt.create(
      notifiable: @submission,
      recipient_name: @submission.applicant_name,
      recipient_email: @submission.applicant_email,
      actioned_by: current_user)

    flash[:notice] =
      "An Application Receipt has been sent to #{@submission.applicant_email}"
  end

  def init_new_submission
    if params[:submission][:task].to_sym != :new_registration
      params[:submission].delete(:vessel)
    end

    @submission = Submission.new(submission_params)
    @submission.source = :manual_entry
    @submission.state = :assigned
    @submission.claimant = current_user
  end
end
