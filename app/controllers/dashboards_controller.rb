class DashboardsController < InternalPagesController
  layout "application"
  def show
    redirect_to activity_root(activity) if activity
  end

  protected

  def activity
    params[:activity]
  end
end
