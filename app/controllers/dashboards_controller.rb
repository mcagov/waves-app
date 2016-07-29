class DashboardsController < InternalPagesController
  def show
    @registrations = Registration.all
  end
end
