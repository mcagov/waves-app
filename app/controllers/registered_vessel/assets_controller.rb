class RegisteredVessel::AssetsController < InternalPagesController
  before_action :load_vessel

  def destroy
    asset = Asset.find(params[:id])
    asset.file.clear
    asset.removed_by = current_user
    asset.save

    flash[:notice] = "The file has been removed from the system"
    redirect_to vessel_path(@vessel)
  end
end
