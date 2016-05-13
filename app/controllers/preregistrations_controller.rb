class PreregistrationsController < ApplicationController
  def new
    @preregistration = Preregistration.new
  end

  def create
    @preregistration = Preregistration.new(preregistration_params)

    if @preregistration.valid?
      head :ok
    else
      render :new
    end
  end

  private

  def preregistration_params
    params.require(:preregistration).permit(
      :not_registered_under_part_1,
      :not_registered_before_on_ssr,
      :owners_are_uk_residents,
      :user_eligible_to_register
    )
  end
end
