class Submission::NameReservationsController < InternalPagesController
  before_action :load_submission

  def show
    @name_reservation =
      Submission::NameReservation.new(part: @submission.part)
  end

  def update
    @name_reservation = Submission::NameReservation.new(name_reservation_params)
    @name_validated = @name_reservation.valid?

    if @name_validated && params[:name_validated]
      if Builders::NameReservationBuilder.build(@submission, @name_reservation)
        redirect_to edit_submission_path(@submission)
      end
    end

    render :show
  end

  protected

  def load_submission
    @submission =
      Submission.in_part(current_activity.part).find(params[:submission_id])
  end

  def name_reservation_params
    params.require(:submission_name_reservation).permit(
      :part, :name, :registration_type, :port_code, :port_no, :net_tonnage)
  end
end
