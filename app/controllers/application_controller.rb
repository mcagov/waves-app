class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  # suppress PaperTrail warning: https://git.io/vrTsk
  def user_for_paper_trail
    nil # disable whodunnit tracking
  end
end
