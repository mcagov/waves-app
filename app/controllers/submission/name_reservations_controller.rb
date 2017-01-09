class Submission::NameReservationsController < InternalPagesController
  before_action :load_submission

  def show
    @name_reservation =
      Submission::NameReservation.new(part: @submission.part)
  end

  protected

  def load_submission
    @submission =
      Submission.in_part(current_activity.part).find(params[:submission_id])
  end
end
