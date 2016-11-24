class RegistrationsController < InternalPagesController
  def show
    @registration = Registration.find(params[:id])
    @task = :new_registration
    @part = :part_3
  end
end
