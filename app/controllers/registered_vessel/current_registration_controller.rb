class RegisteredVessel::CurrentRegistrationController < InternalPagesController
  def update
    @vessel = Register::Vessel.find(params[:vessel_id])
    @registration = @vessel.current_registration

    if @registration.update_attributes(registration_params)
      flash[:notice] = "The registration dates have been updated"
    end

    redirect_to vessel_path(@vessel)
  end

  protected

  def registration_params
    params.require(:registration).permit(:registered_at, :registered_until)
  end
end
