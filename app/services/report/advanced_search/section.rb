class Report::AdvancedSearch::Section
  include ActiveSupport::Inflector

  attr_reader :key, :criteria

  def initialize(params)
    @key = params[0]
    @criteria = params[1]
  end

  def title
    @key.to_s.titleize
  end

  def fieldset_id
    "filter_#{@key}"
  end

  def add_search_criteria_label
    "add_criteria[show_#{@key}]"
  end

  def add_search_criteria_field
    "show_#{@key}"
  end
end
