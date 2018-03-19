class RegisteredVessel::CorrespondencesController < InternalPagesController
  before_action :load_vessel

  def create
    @correspondence = Correspondence.new(correspondence_params)
    @correspondence.actioned_by = current_user
    @correspondence.noteable = @vessel

    flash[:notice] = "The correspondence has been saved" if @correspondence.save

    redirect_to vessel_path(@vessel)
  end

  def destroy
    @correspondence = Correspondence.find(params[:correspondence_id])
    if @correspondence
      @correspondence.destroy
      flash[:notice] = "That item of correspondence has been removed"
    end

    redirect_to vessel_path(@vessel)
  end

  private

  def correspondence_params
    params.require(:correspondence)
          .permit(:subject, :format, :noted_at, :content)
  end
end
