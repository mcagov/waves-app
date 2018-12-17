class RegisteredVessel::RenewalReminderController <
  InternalPagesController
  def create
    @vessel = Register::Vessel.find(params[:vessel_id])
    RegistrationRenewalReminder.new(@vessel).process_reminder!

    flash[:notice] =
      "Renewal Reminder Letter(s) have been sent to the Print Queue"
    redirect_to vessel_path(@vessel)
  end
end
