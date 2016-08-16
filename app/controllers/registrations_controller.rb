class RegistrationsController < InternalPagesController
  def show
    @registration = Registration.includes([:vessel, :payment]).find(params[:id])
  end
end
