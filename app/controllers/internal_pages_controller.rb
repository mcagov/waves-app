class InternalPagesController < ApplicationController
  layout "internal"

  before_action :authenticate_user!

  def render_pdf(pdf, filename)
    send_data pdf.render,
              filename: filename,
              type: "application/pdf",
              disposition: "inline"
  end

  private

  def current_activity
    session[:current_activity] ||= :part_3
    Activity.new(session[:current_activity])
  end
  helper_method :current_activity

  def activity_root(activity)
    session[:current_activity] = activity.to_sym
    current_activity.root_path
  end

  def log_work!(submission, logged_info, description)
    WorkLog.create(
      submission: submission,
      logged_info: logged_info,
      logged_type: logged_info.class.to_s,
      description: description,
      actioned_by: current_user,
      part: current_activity.part)
  end

  def load_vessel
    @vessel = Register::Vessel.find(params[:vessel_id])
  end

  def load_submission
    @submission =
      Submission.includes(:declarations).find(params[:submission_id])
  end

  def enable_readonly
    @readonly = Policies::Actions.readonly?(@submission, current_user)
  end
end
