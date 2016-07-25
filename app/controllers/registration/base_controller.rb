class Registration::BaseController < ApplicationController
  private

  def store_in_session(step, params, datatype=:string)
    case datatype
      when :string
        cookies[step] = params.to_json
      when :array
        counter = cookies["#{ step }_count"].to_i + 1
        cookies["#{ step }_count"] = counter
        cookies["#{ step }_#{ counter }"] = params.to_json
    end
  end

  def get_from_session(key)
    klass_name = key.to_s.camelize
    klass_name.constantize.new(JSON.parse(cookies[key]))
  end

  def remove_from_session(key)
    cookies.delete(key.to_s)
  end
end
