class DashboardsController < InternalPagesController
  layout "application"
  def show
    redirect_to activity_root(params[:activity]) if params[:activity]
  end
end
