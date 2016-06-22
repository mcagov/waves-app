class Registration::BaseController < ApplicationController
  private

  def store_in_session(step, params)
    session[:last_step] = step
    session[step] = params

    #byebug
  end

  def get_from_session(key)
    klass_name = key.to_s.camelize
    klass_name.constantize.new(session[key])
  end
end
