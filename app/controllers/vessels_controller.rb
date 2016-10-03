class VesselsController < InternalPagesController
  def show
    @vessel = Register::Vessel.find(params[:id])

    respond_to do |format|
      format.html
      format.pdf
    end
  end

  def index
    @vessels =
      Register::Vessel.paginate(page: params[:page], per_page: 20).order(:name)
  end
end
