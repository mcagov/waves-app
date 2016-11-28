class RegistrationsController < InternalPagesController
  def show
    @registration = Registration.find(params[:id])
    @registered_vessel = @registration.registered_vessel
    @print_jobs = PrintJob.where(printable: @registration)
  end
end
