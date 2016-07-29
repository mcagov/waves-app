class DashboardsController < InternalPagesController
  def show
    @registrations = Registration.includes(:vessel).all
  end
end
