class SubmissionsController < InternalPagesController
  before_action :load_submission, except: [:show]

  def show
    submission = Submission.includes(
      [:payments, :correspondences, :notifications]).find(params[:id])

    if submission.officer_intervention_required?
      return redirect_to manual_entry_path(submission)
    end

    @submission = Decorators::Submission.new(submission)
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

  def claim
    @submission.claimed!(current_user)

    respond_to do |format|
      format.html do
        flash[:notice] = "You have succesfully claimed this application"
        redirect_to submission_path(@submission)
      end
      format.js { render "tasks/actions/claim_button" }
    end
  end

  def unclaim
    @submission.unclaimed!

    respond_to do |format|
      format.html do
        flash[:notice] = "Application has been moved into Unclaimed Tasks"
        redirect_to tasks_my_tasks_path
      end
      format.js { render "tasks/actions/claim_button" }
    end
  end

  def claim_referral
    @submission.unreferred!
    @submission.claimed!(current_user)

    flash[:notice] = "You have succesfully claimed this application"
    redirect_to tasks_my_tasks_path
  end

  def approve
    if @submission.approved!(params[:registration_starts_at])
      Builders::NotificationBuilder
        .application_approval(
          @submission, current_user, params[:notification_attachments])

      @submission = Decorators::Submission.new(@submission)
      render "approved"
    else
      render "errors"
    end
  end

  protected

  def load_submission
    @submission = Submission.find(params[:id])
  end

  # rubocop:disable Metrics/MethodLength
  def submission_params
    params.require(:submission).permit(
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
end
