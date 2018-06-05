class Admin::NotificationsController < InternalPagesController
  before_action :system_manager_only!

  def index
    @notifications = Notification.pending_approval
    @notifications.paginate(page: params[:page], per_page: 100).all
  end
end
