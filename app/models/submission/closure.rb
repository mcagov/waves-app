class Submission::Closure < WavesUtilities::Closure
  def initialize(params = {})
    params.reject! { |param| !respond_to?(param) }
    assign_attributes(params)
  end

  def assign_attributes(params = {})
    params.each { |key, value| instance_variable_set("@#{key}", value) }
  end

  def actioned_at
    Date.new(actioned_year.to_i, actioned_month.to_i, actioned_day.to_i)
  rescue
    nil
  end
end
