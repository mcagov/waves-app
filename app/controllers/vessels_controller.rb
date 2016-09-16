class VesselsController < InternalPagesController
  def show
    @vessel = Register::Vessel.find(params[:id])
  end
end
