class ApplicationController < ActionController::Base
  include Clearance::Controller
  layout :determine_layout

  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  private

  def determine_layout
    current_user ? "private" : "application"
  end
end
