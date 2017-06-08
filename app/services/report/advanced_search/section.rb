class Report::AdvancedSearch::Section
  include ActiveSupport::Inflector

  def initialize(key)
    @key = key.to_sym
  end

  def title
    @key.to_s.titleize
  end

  def fieldset_id
    "filter_#{@key}"
  end
end
