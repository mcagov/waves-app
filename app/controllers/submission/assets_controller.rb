class Submission::AssetsController < InternalPagesController
  before_action :load_submission

  def destroy
    asset = Asset.find(params[:id])
    asset.file.clear
    asset.removed_by = current_user
    asset.save

    flash[:notice] = "The file has been removed from the system"
    redirect_to submission_path(@submission)
  end
end
