class VesselsController < InternalPagesController
  def show
    @vessel =
      Register::Vessel.where(part: current_activity.part.to_s)
                      .find(params[:id])
  end

  def index
    @vessels =
      Register::Vessel.where(part: current_activity.part.to_s)
                      .paginate(page: params[:page], per_page: 20)
                      .order(:name)
  end
end
