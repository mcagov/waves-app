class VesselsController < InternalPagesController
  def show
    @vessel = Register::Vessel.find(params[:id])
  end

  def index
    @vessels =
      Register::Vessel.paginate(page: params[:page], per_page: 20)
  end
end
