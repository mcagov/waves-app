class SubmissionsController < InternalPagesController
  before_action :load_submission,
                only: [:show, :edit, :update]
  before_action :check_officer_intervention_required,
                only: [:show, :edit, :update]

  def new
    @submission = Submission.new
  end

  def create
    @submission = Submission.new(submission_params)

    if @submission.save
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
        ]).find(params[:id])
  end

  # rubocop:disable Metrics/MethodLength
  def submission_params
    params.require(:submission).permit(
      :applicant_name, :applicant_email,
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
end
