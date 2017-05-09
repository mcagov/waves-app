class RegisteredVessel::ColdStorageController < InternalPagesController
  before_action :load_vessel

  def create
    if @vessel.registration_status == :frozen
      @vessel.update_attribute(:frozen_at, nil)
    else
      @vessel.update_attribute(:frozen_at, Time.now)
    end

    redirect_to vessel_path(@vessel)
  end
end
