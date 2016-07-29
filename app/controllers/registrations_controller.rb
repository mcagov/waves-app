class RegistrationsController < InternalPagesController
  def show
    @registration = Registration.find(params[:id])
  end
end
