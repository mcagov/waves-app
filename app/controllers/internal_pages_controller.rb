class InternalPagesController < ApplicationController
  layout "internal"

  before_action :require_login
  before_action :set_paper_trail_whodunnit

  def user_for_paper_trail
    current_user
  end

  def render_pdf(pdf, filename)
    send_data pdf.render,
              filename: filename,
              type: "application/pdf",
              disposition: "inline"
  end

  private

  def current_activity
    Activity.new(session[:current_activity])
  end
  helper_method :current_activity

  def activity_root(activity)
    session[:current_activity] = activity.to_sym
    current_activity.root_path
  end
end
