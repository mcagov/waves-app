class Admin::NotificationsController < InternalPagesController
  before_action :system_manager_only!

  def index
    @notifications = Notification.pending_approval.includes(:notifiable)
                                 .paginate(page: params[:page], per_page: 50)
  end

  def approve_all
    NotificationApproval.run_delayed(current_user)
  end
end
