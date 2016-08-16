class DashboardsController < InternalPagesController
  def show
    @registrations = Registration.includes([:vessel, :payment]).all
  end
end
