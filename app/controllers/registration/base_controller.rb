class Registration::BaseController < ApplicationController
  private

  def store_in_session(step, params)
    session[:last_step] = step
    session[step] = params
  end
end
