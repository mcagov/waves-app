class RegisteredVessel::OfficialNoController < InternalPagesController
  respond_to :js

  def update
    @vessel = Register::Vessel.find(params[:vessel_id])
    @official_no = OfficialNo.new(official_no_params)

    @reg_no = official_no_params[:content]

    if reg_no_is_invalid
      render :error
    else
      Builders::OfficialNoBuilder.update(@vessel, @reg_no)
      render :update
    end
  end

  protected

  def official_no_params
    params.require(:official_no).permit(:content)
  end

  def reg_no_is_invalid
    @reg_no && @reg_no != @vessel.reg_no &&
      !RegNoValidator.valid?(@reg_no, current_activity.part)
  end
end
