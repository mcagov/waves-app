class Registration::BaseController < ApplicationController
  private

  def store_in_session(step, params)
    cookies[step] = params.to_json
  end

  def get_from_session(key)
    klass_name = key.to_s.camelize
    klass_name.constantize.new(JSON.parse(cookies[key]))
  end
end
