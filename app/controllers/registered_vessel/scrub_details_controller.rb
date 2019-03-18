class RegisteredVessel::ScrubDetailsController < InternalPagesController
  before_action :load_vessel

  def create
    if params[:vessel_reg_no] != @vessel.reg_no
      flash[:error] =
        "The Official Number was not entered correctly. "\
        "No action was performed."
    else
      Anonymizer.new(@vessel, current_user).perform
      flash[:notice] = "The personal details have been removed."
    end

    redirect_to vessel_path(@vessel)
  end
end
