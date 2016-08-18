class DashboardsController < InternalPagesController
  def show
    redirect_to "/tasks/unclaimed"
  end
end
